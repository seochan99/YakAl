package com.viewpharm.yakal.main.model

data class PillTodo(
    val id: Int,
    val name: String,
    val effect: String,
    val kdCode: String,
    val atcCode: AtcCode,
    val count: Int,
    val isOverLap: Boolean,
    val isTaken: Boolean,
)