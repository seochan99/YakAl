package com.viewpharm.yakal.signin.response

import com.viewpharm.yakal.common.YakalError

data class JwtValidResponse(
    val success: Boolean,
    val data: JwtValid?,
    val error: YakalError?,
)
data class JwtValid(
    val validity: JwtValidEnum
)

enum class JwtValidEnum(val value: String) {
    VALID("VALID"),
    INVALID("INVALID"),
    EXPIRED("EXPIRED"),
}