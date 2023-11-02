package com.viewpharm.yakal.common.security;

import com.viewpharm.yakal.common.constants.Constants;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.common.JwtTokenDto;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EPlatform;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.common.exception.CommonException;
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
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.security.Key;
import java.util.Date;
import java.util.Objects;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtProvider implements InitializingBean {

    private static final Long MOBILE_ACCESS_EXPIRED_MS = 2 * 60 * 60 * 1000L;        // 2 Hours
    private static final Long MOBILE_REFRESH_EXPIRED_MS = 60 * 24 * 60 * 60 * 1000L; // 60 Days

    private static final Long WEB_ACCESS_EXPIRED_MS = 60 * 60 * 1000L;           // 1 Hours
    private static final Long WEB_REFRESH_EXPIRED_MS = 7 * 24 * 60 * 60 * 1000L; // 7 Days

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

    public int getWebRefreshTokenExpirationSecond() {
        return (int) (WEB_REFRESH_EXPIRED_MS / 1000);
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

    @Transactional
    public JwtTokenDto reissue(final String refreshToken, final EPlatform platform) throws CommonException {
        final Claims claims = validateToken(refreshToken);

        final Long id = Long.valueOf(claims.get(Constants.USER_ID_CLAIM_NAME).toString());
        final ERole role = ERole.valueOf(claims.get(Constants.USER_ROLE_CLAIM_NAME).toString());

        final User user = userRepository.findById(id).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (!Objects.equals(user.getId(), id) || user.getRole() != role || !user.getRefreshToken().equals(refreshToken)) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        final JwtTokenDto jwtTokenDto = createTotalToken(id, role, platform);

        user.setRefreshToken(jwtTokenDto.getRefreshToken());

        return jwtTokenDto;
    }

    public Claims validateToken(final String token) throws ExpiredJwtException, JwtException {
        final JwtParser jwtParser = Jwts.parserBuilder().setSigningKey(key).build();
        return jwtParser.parseClaimsJws(token).getBody();
    }
}