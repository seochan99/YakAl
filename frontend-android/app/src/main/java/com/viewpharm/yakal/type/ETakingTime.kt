package com.viewpharm.yakal.type

enum class ETakingTime(private val time: String) {
    MORNING("아침"),
    AFTERNOON("점심"),
    EVENING("저녁"),
    DEFAULT("기타"),
    INVISIBLE("빈칸");

    override fun toString(): String {
        return time
    }
}