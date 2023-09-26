package com.viewpharm.yakal.repository

import com.viewpharm.yakal.main.model.AtcCode
import com.viewpharm.yakal.main.model.OverlapDoses
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.type.ETakingTime

class DoseRepository {
    private val todoSchedule: List<Schedule> = listOf(
        Schedule(
            ETakingTime.MORNING,
            isCompleted = false,
            isExpanded = false,
            listOf(
                PillTodo(
                    id = 1,
                    name = "덱시로펜정",
                    effect = "진해거담제",
                    kdCode = "658700670",
                    AtcCode(code = "J05AR15", score = 4),
                    1,
                    isOverLap = false,
                    isTaken = false),
                PillTodo(
                    id = 2,
                    name = "팩타민플러스정",
                    effect = "소화성 궤양용제",
                    kdCode = "658105820",
                    AtcCode(code = "A11JB", score = 2),
                    1,
                    isOverLap = true,
                    isTaken = false),
                PillTodo(
                    id = 3,
                    name = "한풍쌍화탕액",
                    effect = "진해거담제",
                    kdCode = "658105760",
                    AtcCode(code = "A11JB", score = 3),
                    1,
                    isOverLap = true,
                    isTaken = false),
                PillTodo(
                    id = 4,
                    name = "그린헥시딘스틱스왑액",
                    effect = "항히스타민제",
                    kdCode = "648301120",
                    AtcCode(code = "D08AX08", score = 1),
                    1,
                    isOverLap = false,
                    isTaken = false),
            )
        ),
        Schedule(
            ETakingTime.AFTERNOON,
            isCompleted = false,
            isExpanded = false,
            listOf(
                PillTodo(
                    id = 5,
                    name = "덱시로펜정",
                    effect = "진해거담제",
                    kdCode = "658700670",
                    AtcCode(code = "J05AR15", score = 4),
                    count = 1,
                    isOverLap = false,
                    isTaken = false),
                PillTodo(
                    id = 6,
                    name = "팩타민플러스정",
                    effect = "소화성 궤양용제",
                    kdCode = "658105820",
                    AtcCode(code = "A11JB", score = 2),
                    count = 1,
                    isOverLap = true,
                    isTaken = false),
                PillTodo(
                    id = 7,
                    name = "한풍쌍화탕액",
                    effect = "진해거담제",
                    kdCode = "658105760",
                    AtcCode(code = "A11JB", score = 3),
                    count = 1,
                    isOverLap = true,
                    isTaken = false),
            )
        ),
        Schedule(
            ETakingTime.EVENING,
            isCompleted = false,
            isExpanded = false,
            listOf(
                PillTodo(
                    id = 8,
                    name = "덱시로펜정",
                    effect = "진해거담제",
                    kdCode = "658700670",
                    AtcCode(code = "J05AR15", score = 4),
                    count = 1,
                    isOverLap = true,
                    isTaken = false),
                PillTodo(
                    id = 9,
                    name = "팩타민플러스정",
                    effect = "소화성 궤양용제",
                    kdCode = "658105820",
                    AtcCode(code = "A11JB", score = 2),
                    count = 1,
                    isOverLap = false,
                    isTaken = false),
                PillTodo(
                    id = 10,
                    name = "한풍쌍화탕액",
                    effect = "진해거담제",
                    kdCode = "658105760",
                    AtcCode(code = "A11JB", score = 3),
                    count = 1,
                    isOverLap = true,
                    isTaken = false),
                PillTodo(
                    id = 11,
                    name = "그린헥시딘스틱스왑액",
                    effect = "항히스타민제",
                    kdCode = "648301120",
                    AtcCode(code = "D08AX08", score = 1),
                    count = 1,
                    isOverLap = false,
                    isTaken = false),
            )
        ),
        Schedule.getInVisibleSchedule()
    )
    private val overlapMaps: Map<ETakingTime, List<OverlapDoses>> = mapOf(
        ETakingTime.MORNING to listOf<OverlapDoses>(
            OverlapDoses(
                kdCodes = listOf("658105820", "658105760"),
                atcCode = "A11JB"
            )
        ),
        ETakingTime.MORNING to listOf<OverlapDoses>(
            OverlapDoses(
                kdCodes = listOf("658105820", "658105760"),
                atcCode = "A11JB"
            )
        ),
        ETakingTime.MORNING to listOf<OverlapDoses>(
            OverlapDoses(
                kdCodes = listOf("658105820", "658105760"),
                atcCode = "A11JB"
            )
        ),
    )

    fun getTodoSchedules(): List<Schedule> {
        return todoSchedule
    }

    fun getOverlapDoses(): Map<ETakingTime, List<OverlapDoses>> {
        return overlapMaps
    }
}