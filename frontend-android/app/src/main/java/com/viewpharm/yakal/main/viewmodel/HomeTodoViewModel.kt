package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.main.model.AtcCode
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.type.ETakingTime
import com.viewpharm.yakal.util.CalendarUtil
import timber.log.Timber
import java.time.LocalDate

class HomeTodoViewModel: BaseViewModel() {
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

    private var totalCnt: Int = 0
    private var takenCnt: Int = 0
    private var date: LocalDate = LocalDate.now()

    init {
        _dateText.value = CalendarUtil.getFormattedDayFromDate(date)
        _schedules.value = listOf(
            Schedule(
                ETakingTime.MORNING,
                isCompleted = false,
                isExpanded = false,
                listOf(
                    PillTodo(
                        id = 1,
                        name = "덱시로펜정",
                        effect = "해열, 진통, 소염제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 0),
                        2,
                        isOverLap = true,
                        isTaken = true),
                    PillTodo(
                        id = 2,
                        name = "동광레바미피드정",
                        effect = "소화성 궤양용제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 2),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 3,
                        name = "코푸정",
                        effect = "진해거담제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 4,
                        name = "베스티온정",
                        effect = "항히스타민제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
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
                        id = 1,
                        name = "덱시로펜정",
                        effect = "해열, 진통, 소염제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 0),
                        2,
                        isOverLap = true,
                        isTaken = true),
                    PillTodo(
                        id = 2,
                        name = "동광레바미피드정",
                        effect = "소화성 궤양용제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 2),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 3,
                        name = "코푸정",
                        effect = "진해거담제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 4,
                        name = "베스티온정",
                        effect = "항히스타민제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                )
            ),
            Schedule(
                ETakingTime.EVENING,
                isCompleted = false,
                isExpanded = false,
                listOf(
                    PillTodo(
                        id = 1,
                        name = "덱시로펜정",
                        effect = "해열, 진통, 소염제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 0),
                        2,
                        isOverLap = true,
                        isTaken = true),
                    PillTodo(
                        id = 2,
                        name = "동광레바미피드정",
                        effect = "소화성 궤양용제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 2),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 3,
                        name = "코푸정",
                        effect = "진해거담제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 4,
                        name = "베스티온정",
                        effect = "항히스타민제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                )
            ),
            Schedule(
                ETakingTime.DEFAULT,
                isCompleted = false,
                isExpanded = false,
                listOf(
                    PillTodo(
                        id = 1,
                        name = "덱시로펜정",
                        effect = "해열, 진통, 소염제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 0),
                        2,
                        isOverLap = true,
                        isTaken = true),
                    PillTodo(
                        id = 2,
                        name = "동광레바미피드정",
                        effect = "소화성 궤양용제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 2),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 3,
                        name = "코푸정",
                        effect = "진해거담제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                    PillTodo(
                        id = 4,
                        name = "베스티온정",
                        effect = "항히스타민제",
                        kdCode = "00000000",
                        AtcCode(code = "00000000", score = 3),
                        1,
                        isOverLap = false,
                        isTaken = false),
                )
            ),
        )

        // totalCnt의 크기는 스케줄 안에 있는 PillTodo의 총 갯수
        totalCnt = _schedules.value?.sumOf { it.todos.size } ?: 0
        // 먹은 횟수는 PillTodo 안에서 isTaking가 true인 것의 갯수
        takenCnt = _schedules.value?.sumOf { it.todos.filter { todo -> todo.isTaken }.size } ?: 0

        _progress.value = (takenCnt * 100 / totalCnt)

        _isExpandedButton.value = false
        _takingText.value = if (totalCnt != 0) { "오늘 복용해야 하는 약은\n총 ${totalCnt}개입니다" } else { "오늘 복용해야 하는 약은\n없습니다." }
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

    class TodoViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return HomeTodoViewModel() as T
        }
    }
}