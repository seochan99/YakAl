package com.viewpharm.yakal.service

import com.google.gson.GsonBuilder
import com.viewpharm.yakal.BuildConfig
import okhttp3.OkHttpClient
import java.util.concurrent.TimeUnit

object YakalRetrofitManager {
    private val okHttpClient = OkHttpClient.Builder()
        .connectTimeout(10, TimeUnit.SECONDS)
        .readTimeout(10, TimeUnit.SECONDS)
        .writeTimeout(10, TimeUnit.SECONDS)
        .build()

    private val gson = GsonBuilder()
        .setLenient()
        .create()

    private val retrofit = retrofit2.Retrofit.Builder()
        .baseUrl(BuildConfig.YAKAL_API_SERVER_URL)
        .client(okHttpClient)
        .addConverterFactory(retrofit2.converter.gson.GsonConverterFactory.create(gson))
        .build()

    val yakalService : YakalService by lazy { retrofit.create(YakalService::class.java) }
}