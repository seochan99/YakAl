package com.viewpharm.yakal.signin.response

import com.viewpharm.yakal.common.YakalError

data class UserValidResponse(
    val success: Boolean,
    val data: UserValid?,
    val error: YakalError?,
)

data class UserValid(
    val isIdentified: Boolean?,
)