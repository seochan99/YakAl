package com.viewpharm.yakal.repository

import com.viewpharm.yakal.common.GoogleTokenResponse
import com.viewpharm.yakal.service.OauthRetrofitManager
import retrofit2.Call
import retrofit2.Response

class GoogleAuthRepository: OAuth2Repository {
    //    override fun getOauth2Token(code: String, callBack: OAuth2Repository.CallBack) {
//        OauthRetrofitManager.googleAuthService.getAccessToken(code = code)
//            .enqueue(object : retrofit2.Callback<GoogleTokenResponse> {
//                override fun onResponse(
//                    call: Call<GoogleTokenResponse>,
//                    response: Response<GoogleTokenResponse>
//                ) {
//                    if (response.isSuccessful) {
//                        response.body()?.let {
//                            callBack.onSuccess(it.access_token)
//                        }
//                    } else {
//                        callBack.onFailure()
//                    }
//                }
//
//                override fun onFailure(call: Call<GoogleTokenResponse>, t: Throwable) {
//                    callBack.onFailure()
//                }
//            })
//    }
    override fun getOauth2Token(code: String, callBack: OAuth2Repository.CallBack) {
        TODO("Not yet implemented")
    }
}