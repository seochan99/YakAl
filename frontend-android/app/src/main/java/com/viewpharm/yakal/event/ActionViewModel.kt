package com.viewpharm.yakal.event

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel

class ActionViewModel: BaseViewModel() {
    private val _addScheduleEvent = MutableLiveData<Event<Unit>>()
    val addScheduleEvent : LiveData<Event<Unit>> = _addScheduleEvent

    fun addScheduleEvent() {
        _addScheduleEvent.value = Event(Unit)
    }

    class ActionViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return ActionViewModel() as T
        }
    }
}