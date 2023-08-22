package com.viewpharm.yakal.common

data class YakalResponse(
    val success: Boolean,
    val data: YakalJwt?,
    val error: YakalError?,
)

data class YakalJwt(
    val accessToken: String,
    val refreshToken: String,
)