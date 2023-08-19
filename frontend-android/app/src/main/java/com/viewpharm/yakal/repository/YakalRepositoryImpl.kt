package com.viewpharm.yakal.repository

import com.viewpharm.yakal.common.GoogleTokenResponse
import com.viewpharm.yakal.common.YakalJwt
import com.viewpharm.yakal.common.YakalResponse
import com.viewpharm.yakal.service.YakalRetrofitManager
import com.viewpharm.yakal.type.ESignInProvider
import retrofit2.Call
import retrofit2.Response

class YakalRepositoryImpl: YakalRepository {
    override fun getYakalToken(
        oauthAccessToken: String,
        provider: ESignInProvider,
        callBack: YakalRepository.CallBack
    ) {
        YakalRetrofitManager.yakalService.also { it ->
            when(provider) {
                ESignInProvider.KAKAO -> it.getJwtByKakao("Bearer $oauthAccessToken")
                ESignInProvider.GOOGLE -> it.getJwtByGoogle("Bearer $oauthAccessToken")
            }.enqueue(object: retrofit2.Callback<YakalResponse> {
                override fun onResponse(
                    call: Call<YakalResponse>,
                    response: Response<YakalResponse>
                ) {
                    response.body()?.let {
                        callBack.getToken((it.data as YakalJwt).accessToken, it.data.refreshToken)
                    }
                }

                override fun onFailure(call: Call<YakalResponse>, t: Throwable) {
                    callBack.failToken()
                }

            })
        }
    }
}