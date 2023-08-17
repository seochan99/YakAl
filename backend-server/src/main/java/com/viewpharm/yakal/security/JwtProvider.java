package com.viewpharm.yakal.security;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.dto.response.JwtTokenDto;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EPlatform;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.exception.CommonException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.security.Key;
import java.util.Date;

@Component
@RequiredArgsConstructor
public class JwtProvider implements InitializingBean {

    private static final Long MOBILE_ACCESS_EXPIRED_MS = 2 * 60 * 60 * 1000L;        // 2 Hours
    private static final Long MOBILE_REFRESH_EXPIRED_MS = 60 * 24 * 60 * 60 * 1000L; // 60 Days

    private static final Long WEB_ACCESS_EXPIRED_MS = 60 * 60 * 1000L;        // 1 Hours
    private static final Long WEB_REFRESH_EXPIRED_MS = 24 * 60 * 60 * 1000L; // 24 Hours

    private static final String AUTHORIZATION_HEADER = "Authorization";
    private static final String BEARER_PREFIX = "Bearer ";

    private final UserRepository userRepository;

    @Value("${jwt.secret: abc}")
    private String secretKey;
    private Key key;

    @Override
    public void afterPropertiesSet() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }

    public String refineToken(final HttpServletRequest request) throws CommonException {
        final String unpreparedToken = request.getHeader(AUTHORIZATION_HEADER);

        if (!StringUtils.hasText(unpreparedToken) || !unpreparedToken.startsWith(BEARER_PREFIX)) {
            throw new CommonException(ErrorCode.INVALID_TOKEN_ERROR);
        }

        return unpreparedToken.substring(BEARER_PREFIX.length());
    }

    public String createToken(final Long id, final ERole role, final Long expirationPeriod) {
        final Claims claims = Jwts.claims();
        claims.put(Constants.USER_ID_CLAIM_NAME, id.toString());
        claims.put(Constants.USER_ROLE_CLAIM_NAME, role.toString());

        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expirationPeriod))
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }

    public JwtTokenDto createTotalToken(final Long id, final ERole ERole, final EPlatform platform) {
        final String accessToken = createToken(id, ERole, platform == EPlatform.MOBILE ? MOBILE_ACCESS_EXPIRED_MS : WEB_ACCESS_EXPIRED_MS);
        final String refreshToken = createToken(id, ERole,  platform == EPlatform.MOBILE ? MOBILE_REFRESH_EXPIRED_MS : WEB_REFRESH_EXPIRED_MS);
        return new JwtTokenDto(accessToken, refreshToken);
    }

    public JwtTokenDto reissueForWeb(final HttpServletRequest request) throws CommonException {
        final String originalRefreshToken = refineToken(request);
        final Claims claims = validateToken(originalRefreshToken);

        final Long id = Long.valueOf(claims.get(Constants.USER_ID_CLAIM_NAME).toString());
        final ERole role = ERole.valueOf(claims.get(Constants.USER_ROLE_CLAIM_NAME).toString());

        if (!userRepository.existsByIdAndRoleAndRefreshToken(id, role, originalRefreshToken)) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        return createTotalToken(id, role, EPlatform.MOBILE);
    }

    public JwtTokenDto reissueForWeb(final String refreshToken) throws CommonException {
        if (!StringUtils.hasText(refreshToken) || !refreshToken.startsWith(BEARER_PREFIX)) {
            throw new CommonException(ErrorCode.INVALID_TOKEN_ERROR);
        }

        final String orgRefreshToken = refreshToken.substring(BEARER_PREFIX.length());

        final Claims claims = validateToken(orgRefreshToken);

        final Long id = Long.valueOf(claims.get(Constants.USER_ID_CLAIM_NAME).toString());
        final ERole role = ERole.valueOf(claims.get(Constants.USER_ROLE_CLAIM_NAME).toString());

        if (!userRepository.existsByIdAndRoleAndRefreshToken(id, role, orgRefreshToken)) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        return createTotalToken(id, role, EPlatform.WEB);
    }

    public Claims validateToken(final String token) throws CommonException {
        try {
            final JwtParser jwtParser = Jwts.parserBuilder().setSigningKey(key).build();
            return jwtParser.parseClaimsJws(token).getBody();
        } catch (ExpiredJwtException e) {
            throw new CommonException(ErrorCode.EXPIRED_TOKEN_ERROR);
        } catch (JwtException e) {
            throw new CommonException(ErrorCode.INVALID_TOKEN_ERROR);
        }
    }
}