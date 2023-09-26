package com.viewpharm.yakal.signin.response

import com.viewpharm.yakal.common.YakalError

data class JwtResponse(
    val success: Boolean,
    val data: Jwt?,
    val error: YakalError?,
)

data class Jwt(
    val accessToken: String,
    val refreshToken: String,
)