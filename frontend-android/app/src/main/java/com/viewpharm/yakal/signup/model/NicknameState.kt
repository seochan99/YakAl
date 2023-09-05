package com.viewpharm.yakal.signup.model

data class NicknameState (
    var nickname: String = "",
    val cancelEnable: Boolean = false,
    val nextEnable: Boolean = false,
)