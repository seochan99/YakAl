package com.viewpharm.yakal.main.activity

import com.viewpharm.yakal.type.ETakingTime

class MainCallBack {
    interface ScheduleCallBack {
        fun onScheduleCheckButtonClick(eTakingTime: ETakingTime)
        fun onClickItemView(eTakingTime: ETakingTime)
    }

    interface TodoCallBack {
        fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId : Int)
    }

    interface OverLapCallback {
        fun onOverLapCheckButtonClick()
    }
}