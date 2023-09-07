package com.viewpharm.yakal.signin.repository

import android.content.Context
import android.content.SharedPreferences
import com.viewpharm.yakal.service.YakalRetrofitManager
import com.viewpharm.yakal.signin.response.Jwt
import com.viewpharm.yakal.signin.response.JwtResponse
import com.viewpharm.yakal.signin.response.JwtValid
import com.viewpharm.yakal.signin.response.JwtValidResponse
import com.viewpharm.yakal.signin.response.UserValid
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import timber.log.Timber

class YakalAuthRepository(private val context: Context) {
    fun getTokenInRemoteByKakao(accessToken: String): Single<Jwt> = YakalRetrofitManager.yakalAuthService.getJwtByKakao("Bearer $accessToken")
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .flatMap { item ->
            Single.just(Jwt(
                item.data!!.accessToken,
                item.data.refreshToken,
            ))
        }


    fun getJwtTokenInDevice(): Single<Jwt> {
        val perf: SharedPreferences = context.getSharedPreferences("token", Context.MODE_PRIVATE)
        return Single.just(
            Jwt(
                perf.getString("accessToken", "")!! ,
                perf.getString("refreshToken", "")!! ,
            )
        )
    }

    fun setJwtTokenInDevice(accessToken: String, refreshToken: String) {
        Timber.d("accessToken : $accessToken\nrefreshToken : $refreshToken")
        context.getSharedPreferences("token", Context.MODE_PRIVATE).edit().apply {
            putString("accessToken", accessToken)
            putString("refreshToken", refreshToken)
            apply()
        }
    }

    suspend fun isValidToken(accessToken: String) :Single<JwtValid> {
        return YakalRetrofitManager.yakalAuthService.isValidJwt("Bearer $accessToken")
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .flatMap { item ->
                Single.just(JwtValid(item.data?.validity!!))
            }
    }

    suspend fun isValidUser(accessToken: String) : Single<UserValid> {
        return YakalRetrofitManager.yakalAuthService.isValidUser("Bearer $accessToken")
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .flatMap { item ->
                Single.just(UserValid(item.data?.isIdentified!!))
            }
    }
}