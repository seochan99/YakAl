package com.viewpharm.yakal.main.model

import java.time.LocalTime

data class TakingTime(
    var startTime: LocalTime,
    var endTime: LocalTime,
) {
    fun getStartTimeString(): String {
        return startTime.toString()
    }

    fun getEndTimeString(): String {
        return endTime.toString()
    }

    override fun toString(): String {
        return "$startTime - $endTime"
    }
}