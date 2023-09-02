package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.main.model.Schedule
import java.util.Date

class HomeTodoViewModel: BaseViewModel() {
    private val _date = MutableLiveData<Date>()
    val date: LiveData<Date> = _date
    private val _progress = MutableLiveData<Int>()
    val progress: LiveData<Int> = _progress
    private val _schedules = MutableLiveData<List<Schedule>>()
    val schedules: LiveData<List<Schedule>> = _schedules
    var totalCnt: Int = 0
    var takenCnt: Int = 0


    init {
        _date.value = Date()
        _progress.value = 0
        _schedules.value = listOf()
        totalCnt = 15
        takenCnt = 0
    }

    fun setPercent(percent: Int) {
        _progress.value = percent
    }

    fun updateTodoStatus(todoId: Int, status: Boolean) {
        // takenCnt update
        if (status) {
            takenCnt += 1
        } else {
            takenCnt -= 1
        }

        // progress update
        _progress.value = (takenCnt * 100 / totalCnt)

        // schedules update(만약 pillTodo 다 했다면 isCompleted를 true로 변경)
        _schedules.value = _schedules.value?.map { schedule ->
            schedule.copy(
                pills = schedule.pills.map { pill ->
                    if (pill.id == todoId) {
                        pill.copy(isTaken = status)
                    } else {
                        pill
                    }
                },
                isCompleted = schedule.pills.all { it.isTaken }
            )
        }
    }

    class ProgressViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return HomeTodoViewModel() as T
        }
    }
}