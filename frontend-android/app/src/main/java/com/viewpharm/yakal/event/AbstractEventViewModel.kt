package com.viewpharm.yakal.event

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.viewpharm.yakal.base.BaseViewModel

abstract class AbstractEventViewModel: BaseViewModel() {
    protected val _addScheduleEvent = MutableLiveData<Event<Unit>>()
    val addScheduleEvent : LiveData<Event<Unit>> = _addScheduleEvent

    protected fun addScheduleEvent() {
        _addScheduleEvent.value = Event(Unit)
    }
}