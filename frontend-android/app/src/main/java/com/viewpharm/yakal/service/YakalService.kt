package com.viewpharm.yakal.service

import com.viewpharm.yakal.common.YakalResponse
import retrofit2.Call
import retrofit2.http.Header
import retrofit2.http.POST

interface YakalService {
    @POST("api/v1/auth/kakao")
    fun getJwtByKakao(
        @Header("Authorization") authorization: String,
    ) : Call<YakalResponse>

    @POST("api/v1/auth/google")
    fun getJwtByGoogle(
        @Header("Authorization") authorization: String,
    ) : Call<YakalResponse>
}