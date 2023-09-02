package com.viewpharm.yakal.main.model

data class PillTodo(
    val id: Int,
    val kdCode: String,
    val atcCode: AtcCode,
    val count: Int,
    val isOverLap: Boolean,
    val isTaken: Boolean
)