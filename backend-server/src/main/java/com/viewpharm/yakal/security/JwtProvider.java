package com.viewpharm.yakal.security;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.dto.JwtTokenDto;
import com.viewpharm.yakal.repository.UserRepository;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.security.Key;
import java.util.Date;

@Component
public class JwtProvider {
    private static final Long ACCESS_EXPIRED_MS = 2 * 60 * 60 * 1000L;        // 2 Hours
    private static final Long REFRESH_EXPIRED_MS = 60 * 24 * 60 * 60 * 1000L; // 60 Days

    private static final String AUTHORIZATION_HEADER = "Authorization";
    private static final String BEARER_PREFIX = "Bearer ";

    private final UserRepository userRepository;

    @Value("${jwt.secret: abc}")
    private String secretKey;
    private final Key key;

    @Autowired
    public JwtProvider(final UserRepository userRepository) {
        final byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);

        this.userRepository = userRepository;
    }

    public String refineToken(final HttpServletRequest request) throws CommonException {
        String unpreparedToken = request.getHeader(AUTHORIZATION_HEADER);

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

    public JwtTokenDto createTotalToken(final Long id, final ERole ERole) {
        final String accessToken = createToken(id, ERole, ACCESS_EXPIRED_MS);
        final String refreshToken = createToken(id, ERole, REFRESH_EXPIRED_MS);
        return new JwtTokenDto(accessToken, refreshToken);
    }

    public JwtTokenDto reissue(final HttpServletRequest request) throws CommonException {
        final String originalRefreshToken = refineToken(request);
        final Claims claims = validateToken(originalRefreshToken);

        final Long id = Long.valueOf(claims.get(Constants.USER_ID_CLAIM_NAME).toString());
        final ERole role = ERole.valueOf(claims.get(Constants.USER_ROLE_CLAIM_NAME).toString());

        if (!userRepository.existsByIdAndRoleAndRefreshToken(id, role, originalRefreshToken)) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER_ERROR);
        }

        return createTotalToken(id, role);
    }

    public String getUserId(final String token) {
        JwtParser jwtParser = Jwts.parserBuilder().setSigningKey(key).build();
        return jwtParser.parseClaimsJws(token)
                .getBody()
                .get("id")
                .toString();
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