package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.main.model.AtcCode
import com.viewpharm.yakal.main.model.OverlapDoses
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.repository.DoseRepository
import com.viewpharm.yakal.type.ETakingTime
import com.viewpharm.yakal.util.CalendarUtil
import timber.log.Timber
import java.time.LocalDate

class HomeTodoViewModel(
    private val doseRepository: DoseRepository
): BaseViewModel() {
    private val _dateText = MutableLiveData<String>()
    val dateText: LiveData<String> = _dateText
    private val _progress = MutableLiveData<Int>()
    val progress: LiveData<Int> = _progress

    private val _schedules = MutableLiveData<List<Schedule>>()
    val schedules: LiveData<List<Schedule>> = _schedules

    private val _takingText = MutableLiveData<String>()
    val takingText: LiveData<String> = _takingText

    private val _addButtonEvent = MutableLiveData<Event<Unit>>()
    val addButtonEvent : LiveData<Event<Unit>> = _addButtonEvent

    private val _isExpandedButton = MutableLiveData<Boolean>()
    val isExpandedButton: LiveData<Boolean> = _isExpandedButton

    private val _totalCntText = MutableLiveData<String>()
    val totalCntText: LiveData<String> = _totalCntText
    private val _takenCntText = MutableLiveData<String>()
    val takenCntText: LiveData<String> = _takenCntText

    private lateinit var overlapDoses: Map<ETakingTime, List<OverlapDoses>>
    private var totalCnt: Int = 0
    private var takenCnt: Int = 0
    private var date: LocalDate = LocalDate.now()

    init {
        initData()
    }

    private fun initData() {
        _dateText.value = CalendarUtil.getFormattedDayFromDate(date)
        _schedules.value = doseRepository.getTodoSchedules()
        overlapDoses = doseRepository.getOverlapDoses()

        // totalCnt의 크기는 스케줄 안에 있는 PillTodo의 총 갯수
        totalCnt = _schedules.value?.sumOf { it.todos.size } ?: 0
        _totalCntText.value = "(${totalCnt}개)"
        // 먹은 횟수는 PillTodo 안에서 isTaking가 true인 것의 갯수
        takenCnt = _schedules.value?.sumOf { it.todos.filter { todo -> todo.isTaken }.size } ?: 0
        _takenCntText.value = takenCnt.toString()

        _progress.value = (takenCnt * 100 / totalCnt)

        _isExpandedButton.value = false
        _takingText.value = if (totalCnt != 0) { "오늘 복용해야 하는 약은\n총 ${totalCnt}개입니다" } else { "오늘 복용해야 하는 약은\n없습니다." }
    }

    fun getOverLapList(eTakingTime: ETakingTime, atcCodeStr: String): List<PillTodo> {
        // overlapDoses에서 시간에 해당하며 ,atc인 코드 찾기
        val pillTodos: List<String> = overlapDoses[eTakingTime]?.filter { it.atcCode == atcCodeStr }?.flatMap { it.kdCodes } ?: listOf()

        // 해당시간에 해당하는 스케줄를 통해 pillTodos에 있는 pill 찾기
        return _schedules.value?.filter { it.eTakingTime == eTakingTime }?.flatMap { it.todos }?.filter { pillTodos.contains(it.kdCode) } ?: listOf()
    }

    fun updateDate(date: LocalDate) {
        this.date = date
        _dateText.value = CalendarUtil.getFormattedDayFromDate(date)
        initData()
    }

    fun updateSchedule(eTakingTime: ETakingTime) {
        // isCompleted 값 변경
        // schedules 중에서 해당하는 시간에 모든 PillTodo True/False로 변경
        _schedules.value = _schedules.value?.map { schedule ->
            if (schedule.eTakingTime == eTakingTime) {
                schedule.copy(
                    todos = schedule.todos.map { pill ->
                        pill.copy(isTaken = !schedule.isCompleted)
                    },
                    isCompleted = !schedule.isCompleted
                )
            } else {
                schedule
            }
        }

        // takenCnt update
        takenCnt = _schedules.value?.sumOf { it.todos.filter { todo -> todo.isTaken }.size } ?: 0
        _takenCntText.value = takenCnt.toString()

        // progress update
        _progress.value = (takenCnt * 100 / totalCnt)
    }

    fun updateTodo(eTakingTime: ETakingTime, todoId: Int) {
        // schedules 중에서 해당하는 시간에 해당하는 PillTodo True/False로 변경 이후 객체의 isCompleted 변경
        _schedules.value = _schedules.value?.map { schedule ->
            var takingCnt: Int = 0;
            if (schedule.eTakingTime == eTakingTime) {
                schedule.copy(
                    todos = schedule.todos.map { pill ->
                        if (pill.id == todoId) {
                            if (!pill.isTaken) takingCnt++
                            pill.copy(isTaken = !pill.isTaken)
                        } else {
                            if (pill.isTaken) takingCnt++
                            pill
                        }
                    },
                    isCompleted = takingCnt == schedule.todos.size
                )
            } else {
                schedule
            }
        }

        // takenCnt update
        takenCnt = _schedules.value?.sumOf { it.todos.filter { todo -> todo.isTaken }.size } ?: 0
        _takenCntText.value = takenCnt.toString()

        // progress update
        _progress.value = (takenCnt * 100 / totalCnt)
    }

    fun onClickScheduleItemView(eTakingTime: ETakingTime) {
        _schedules.value = _schedules.value?.map { schedule ->
            if (schedule.eTakingTime == eTakingTime) {
                Timber.d("schedule.isExpanded : ${schedule.eTakingTime}")
                schedule.copy(
                    isExpanded = !schedule.isExpanded
                )
            } else {
                schedule.copy(
                    isExpanded = false
                )
            }
        }
    }

    fun onAddButtonEvent() {
        _isExpandedButton.value = _isExpandedButton.value?.not()
        _addButtonEvent.value = Event(Unit)
    }

    class TodoViewModelFactory(
        private val doseRepository: DoseRepository
    ): ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return HomeTodoViewModel(doseRepository) as T
        }
    }
}