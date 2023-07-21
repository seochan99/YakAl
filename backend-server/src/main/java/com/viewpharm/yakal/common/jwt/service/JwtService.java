package com.viewpharm.yakal.common.jwt.service;

import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.common.exception.type.ErrorCode;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.jwt.dto.JwtTokenDto;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.security.Key;
import java.util.Date;

@Component
public class JwtService implements InitializingBean {
    private static final Long ACCESS_EXPIRED_MS = 2 * 60 * 60 * 1000L;
    private static final Long REFRESH_EXPIRED_MS = 60 * 24 * 60 * 60 * 1000L;

    private final UserRepository userRepository;

    @Value("${jwt.secret: abc}")
    private String secretKey;
    private Key key;

    @Autowired
    public JwtService(final UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * 요청 개체에서 JWT가 문자열인지 확인하고 접두어 "Bearer "를 제거한 후 반환합니다.
     *
     * @return 정제된 JWT String
     */
    public static String refineToken(final HttpServletRequest request) {
        String unprepared = request.getHeader("Authorization");

        if (!StringUtils.hasText(unprepared) || !unprepared.startsWith("Bearer ")) {
            throw new IllegalArgumentException("Not Valid Or Not Exist Token");
        }

        return unprepared.substring(7);
    }

    /**
     * JwtService의 빈이 초기화될 때 JWT Secret Key를 통해 HMAC-SHA 알고리듬으로 키 인스턴스를 생성하고 멤버 변수로 저장한다.
     */
    @Override
    public void afterPropertiesSet() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }

    /**
     * JWT 토큰을 생성하여 반환한다. 토큰 페이로드에는 기본적으로 User의 ID가 필요하며 액세스 토큰인 경우 ADMIN 여부까지 포함된다.
     *
     * @param id            User 테이블의 PK인 UUID
     * @param EUserRole  User가 ADMIN인지 여부
     * @param isAccessToken 액세스 토큰인지 리프레시 토큰인지 여부
     * @return 생성된 JWT
     */
    public String createToken(final Long id, final EUserRole EUserRole, final boolean isAccessToken) {
        Claims claims = Jwts.claims();
        claims.put("id", id);

        if (isAccessToken) {
            claims.put("userRoleType", EUserRole);
        }

        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + (isAccessToken ? ACCESS_EXPIRED_MS : REFRESH_EXPIRED_MS)))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * 액세스 토큰과 리프레시 토큰을 생성하여 JwtTokenDto로 래핑한 다음 반환합니다.
     */
    public JwtTokenDto createTotalToken(final Long id, final EUserRole EUserRole) {
        String accessToken = createToken(id, EUserRole, true);
        String refreshToken = createToken(id, EUserRole, false);

        return JwtTokenDto.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }

    /**
     * 리프레시 토큰이 포함된 요청을 받으면 해당 리프레시 토큰의 유효성을 검사하고 유효하다면 액세스 토큰을 새로 발급한다.
     *
     * @param request 리프레시 토큰이 포함된 요청
     * @return 새로 발급된 액세스 토큰
     * @throws JwtException 유효하지 않은 리프레시 토큰이 입력된 경우 발생
     */
    public String validRefreshToken(final HttpServletRequest request) throws JwtException {
        String refreshToken = refineToken(request);
        Claims claims = validateToken(refreshToken);

        UserRepository.UserLoginForm user = userRepository.findByIdAndRefreshToken(Long.valueOf(claims.get("id").toString()), refreshToken)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return createToken(user.getId(), user.getUserRole(), true);
    }

    public String getUserId(final String token) {
        JwtParser jwtParser = Jwts.parserBuilder().setSigningKey(key).build();
        return jwtParser.parseClaimsJws(token)
                .getBody()
                .get("id")
                .toString();
    }

    /**
     * JWT의 유효성과 만료 여부를 확인한 후 JWT의 body 정보를 담고있는 Claims 개체를 반환합니다.
     *
     * @param token JWT String
     * @return JWT의 body 정보를 담고 있는 Claims 개체를 반환한다.
     * @throws JwtException 입력 토큰이 유효하지 않을 경우 해당하는 JwtException 발생
     */
    public Claims validateToken(final String token) throws JwtException {
        JwtParser jwtParser = Jwts.parserBuilder().setSigningKey(key).build();
        return jwtParser.parseClaimsJws(token).getBody();
    }
}