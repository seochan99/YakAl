package com.viewpharm.yakal.repository

import com.viewpharm.yakal.type.ESignInProvider

interface YakalRepository {
    fun getYakalToken(oauthAccessToken: String, provider: ESignInProvider,  callBack: CallBack)

    interface CallBack {
        fun getToken(accessToken: String, refreshToken: String)
        fun failToken()
    }
}