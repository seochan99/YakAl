package com.viewpharm.yakal

enum class ETakingTime(private val time: String) {
    MORNING("아침"),
    AFTERNOON("점심"),
    EVENING("저녁"),
    DEFAULT("기타");

    public override fun toString(): String {
        return time
    }
}