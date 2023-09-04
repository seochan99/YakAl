package com.viewpharm.yakal.main.model

import com.viewpharm.yakal.type.ETakingTime

data class Schedule (
    val eTakingTime: ETakingTime,
    val isCompleted : Boolean,
    val isExpanded : Boolean,
    val todos : List<PillTodo>
) {
    companion object {
        fun getInVisibleSchedule() : Schedule {
            return Schedule(
                ETakingTime.INVISIBLE,
                isCompleted = false,
                isExpanded = false,
                todos = listOf()
            )
        }
    }

    fun getTotalCnt() : String {
        return "${todos.size.toString()} 개"
    }

    override fun toString(): String {

        return "Schedule(eTakingTime=$eTakingTime,\n" +
                "isCompleted=$isCompleted,\n" +
                "isExpanded=$isExpanded,\n" +
                "todos=$todos)\n"
    }
}