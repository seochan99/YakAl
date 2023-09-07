package com.viewpharm.yakal.main.model

import java.time.LocalDate

data class DayState(
    val date: LocalDate,
    val dateOfDay: String,
    val percent: Int,
    val isOverlap: Boolean,
    val isVisible: Boolean,
    val isSelected: Boolean,
)