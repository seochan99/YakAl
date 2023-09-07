package com.viewpharm.yakal.signin.service

import com.viewpharm.yakal.signin.response.JwtResponse
import com.viewpharm.yakal.signin.response.JwtValidResponse
import com.viewpharm.yakal.signin.response.UserValidResponse
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.POST

interface YakalAuthService {
    @POST("api/v1/auth/kakao")
    fun getJwtByKakao(
        @Header("Authorization") authorization: String,
    ) : Single<JwtResponse>

    @POST("api/v1/auth/google")
    fun getJwtByGoogle(
        @Header("Authorization") authorization: String,
    ) : Single<JwtResponse>

    @GET("api/v1/auth/validate")
    // 토큰 유효성 검사
    fun isValidJwt(
        @Header("Authorization") authorization: String,
    ) : Single<JwtValidResponse>

    @GET("api/v1/user/check/identification")
    // 토큰 유효성 검사
    fun isValidUser(
        @Header("Authorization") authorization: String,
    ) : Single<UserValidResponse>
}