package com.viewpharm.yakal.model

import com.viewpharm.yakal.type.ETakingTime

data class PillTodo(
    val ETime: ETakingTime,
    var totalCnt : Int,
    var completed : Boolean,
    var isExpanded : Boolean,
    val pills : List<Pill>
) {
    public fun getTotalPillCnt() : Int = totalCnt
}