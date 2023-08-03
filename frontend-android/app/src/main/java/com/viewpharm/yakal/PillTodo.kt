package com.viewpharm.yakal

data class PillTodo(
    val ETime: ETakingTime,
    var totalCnt : Int,
    var completed : Boolean,
    var isExpanded : Boolean,
    val pills : List<Pill>
) {
    public fun getTotalPillCnt() : Int = totalCnt
}

data class Pill(
    val name: String,
    var completed: Boolean
)