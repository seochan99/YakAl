package com.viewpharm.yakal.main.activity

import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.model.TakingTime
import com.viewpharm.yakal.type.ETakingTime
import java.time.LocalDate

class MainCallBack {
    interface ScheduleCallBack {
        fun onTodoCheckButtonClick(eTakingTime: ETakingTime)
        fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId : Int)
        fun onClickItemView(eTakingTime: ETakingTime)
    }

    interface TodoCallBack {
        fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId : Int)
    }

    interface OverLapCallback {
        fun onOverLapCheckButtonClick(pillTodos: List<PillTodo>)
    }

    interface TimeSettingCallback {
        fun onTimeSettingButtonClick(takingTime: TakingTime)
    }

    interface LogOutCallback {
        fun onLogOutButtonClick()
    }

    interface CalendarCallback {
        fun onCalendarButtonClick(date: LocalDate)
    }
}