package com.viewpharm.yakal.signup

import com.viewpharm.yakal.common.YakalError

data class YakAlResponseDto(
    val success: Boolean,
    val data: Any?,
    val error: YakalError?,
)
