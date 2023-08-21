package com.viewpharm.yakal.repository


interface OAuth2Repository {
    fun getOauth2Token(code: String, callBack: OAuth2Repository.CallBack)

    interface CallBack {
        fun onSuccess(token: String)
        fun onFailure()
    }
}