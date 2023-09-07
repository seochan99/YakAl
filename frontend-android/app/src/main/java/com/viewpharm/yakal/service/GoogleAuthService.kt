package com.viewpharm.yakal.service

import com.viewpharm.yakal.BuildConfig
import com.viewpharm.yakal.common.GoogleTokenResponse
import io.reactivex.Single
import retrofit2.Call
import retrofit2.http.Header
import retrofit2.http.POST
import retrofit2.http.Query

interface GoogleAuthService {
    @POST("/token")
    fun getAccessToken(
        @Header("Content-type") contentType: String = "application/x-www-form-urlencoded",
        @Header("charset") charset: String = "UTF-8",
        @Query("grant_type") grantType: String = "authorization_code",
        @Query("client_id") clientId: String = BuildConfig.GOOGLE_CLIENT_ID,
        @Query("client_secret") clientSecret: String = BuildConfig.GOOGLE_CLIENT_SECRET,
        @Query("redirect_uri") redirectUri: String = BuildConfig.GOOGLE_REDIRECT_URI,
        @Query("code") code: String
    ) : Single<GoogleTokenResponse>
}