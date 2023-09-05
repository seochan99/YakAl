package com.viewpharm.yakal.signup.model

import com.viewpharm.yakal.type.EMode

data class Modestate(
    val mode: EMode = EMode.NONE,
    var isNextEnable: Boolean = false,
)