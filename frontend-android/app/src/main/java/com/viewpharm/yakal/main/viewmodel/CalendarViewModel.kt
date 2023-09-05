package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.main.model.DayState
import com.viewpharm.yakal.util.CalendarUtil
import java.time.LocalDate

class CalendarViewModel: BaseViewModel() {
    private val _calendarTakings = MutableLiveData<List<DayState>>()
    val calendarTakings: LiveData<List<DayState>> = _calendarTakings
    var isChange: Boolean = false
        private set

    private val _selectedDate = MutableLiveData<LocalDate>()
    val selectedDate: LiveData<LocalDate> = _selectedDate

    // Expand/Collapse BottomEvent 처리
    private val _expandBottomEvent = MutableLiveData<Event<Unit>>()
    val expandBottomEvent: LiveData<Event<Unit>> = _expandBottomEvent

    private val _monthString = MutableLiveData<String>()
    val monthString: LiveData<String> = _monthString

    var isExpanded = false
        private set

    init {
        _selectedDate.value = LocalDate.now()
        _monthString.value = CalendarUtil.getFormattedMonthFromDate(_selectedDate.value!!)
        _calendarTakings.value = CalendarUtil.daysInWeekArray(_selectedDate.value!!)
    }

    fun updateSelectedDate(date: LocalDate) {
        _selectedDate.value = date
        isChange = true

        // _calendarTakings에서 해당 날짜 찾아서 isSelected = true 및 나머지는 false
        _calendarTakings.value = _calendarTakings.value!!.map {
            if (it.date == date) {
                it.copy(isSelected = true)
            } else {
                it.copy(isSelected = false)
            }
        }
    }

    fun onClickExpandBottomEvent() {
        _expandBottomEvent.value = Event(Unit)
        isExpanded = !isExpanded

        if (isExpanded) {
            _calendarTakings.value = CalendarUtil.daysInMonthArray(_selectedDate.value!!)
        } else {
            _calendarTakings.value = CalendarUtil.daysInWeekArray(_selectedDate.value!!)
        }
    }

    // 주 바뀌면 List 변경
    fun nextDate() {
        if (isExpanded) {
            _selectedDate.value = _selectedDate.value?.plusMonths(1)
            _calendarTakings.value = CalendarUtil.daysInMonthArray(_selectedDate.value!!)
        } else {
            _selectedDate.value = _selectedDate.value?.plusDays(7)
            _calendarTakings.value = CalendarUtil.daysInWeekArray(_selectedDate.value!!)
        }
        _monthString.value = CalendarUtil.getFormattedMonthFromDate(_selectedDate.value!!)
    }

    fun previousDate() {
        if (isExpanded) {
            _selectedDate.value = _selectedDate.value?.minusMonths(1)
            _calendarTakings.value = CalendarUtil.daysInMonthArray(_selectedDate.value!!)
        } else {
            _selectedDate.value = _selectedDate.value?.minusDays(7)
            _calendarTakings.value = CalendarUtil.daysInWeekArray(_selectedDate.value!!)
        }
        _monthString.value = CalendarUtil.getFormattedMonthFromDate(_selectedDate.value!!)
    }

    fun updateIsChange() {
        isChange = false
    }

    class CalendarViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return CalendarViewModel() as T
        }
    }
}