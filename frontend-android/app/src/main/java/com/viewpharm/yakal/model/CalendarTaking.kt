package com.viewpharm.yakal.model

data class CalendarTaking(
    val percent: Int,
    val dateOfDay: String,   // 변경 예정
    val isOverlap: Boolean
)