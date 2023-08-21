package com.viewpharm.yakal

import android.app.Application
import android.content.Context
import com.kakao.sdk.common.KakaoSdk
import com.kakao.sdk.v2.auth.BuildConfig

class YakalApplication: Application() {

    companion object {
        var appContext : Context? = null
    }
    override fun onCreate() {
        super.onCreate()
        appContext = this
        KakaoSdk.init(this, com.viewpharm.yakal.BuildConfig.KAKAO_NATIVE_KEY)
    }
}