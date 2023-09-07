package com.viewpharm.yakal.signin.repository


interface OAuth2Repository {
    fun getOauth2Token(code: String, callBack: CallBack)

    interface CallBack {
        fun onSuccess(token: String)
        fun onFailure()
    }
}