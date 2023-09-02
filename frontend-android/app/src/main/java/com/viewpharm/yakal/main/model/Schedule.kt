package com.viewpharm.yakal.main.model

import com.viewpharm.yakal.type.ETakingTime

data class Schedule (
    val eTakingTime: ETakingTime,
    var isCompleted : Boolean,
    var isExpanded : Boolean,
    val pills : List<PillTodo>
)