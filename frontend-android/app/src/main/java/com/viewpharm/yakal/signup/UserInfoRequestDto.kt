package com.viewpharm.yakal.signup

data class UserInfoRequestDto(
    val name: String,
    val isDetail: Boolean,
    val birthday: String,
    val sex: String
)
