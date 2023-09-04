package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event

class MainViewModel: BaseViewModel() {
    private val _overLapEvent = MutableLiveData<Event<Unit>>()
    val overLapEvent : LiveData<Event<Unit>> = _overLapEvent

    private val _calendarEvent = MutableLiveData<Event<Unit>>()
    val calendarEvent : LiveData<Event<Unit>> = _calendarEvent

    private val _toastEvent = MutableLiveData<Event<Unit>>()
    val toastEvent : LiveData<Event<Unit>> = _toastEvent
    var message : String = ""

    private val _signOutEvent = MutableLiveData<Event<Unit>>()
    val signOutEvent : LiveData<Event<Unit>> = _signOutEvent

    private val _deleteLocationEvent = MutableLiveData<Event<Unit>>()
    val deleteLocationEvent : LiveData<Event<Unit>> = _deleteLocationEvent

    fun onCalendarEvent() {
        _calendarEvent.value = Event(Unit)
    }

    fun onToastEvent(message: String) {
        this.message = message
        _toastEvent.value = Event(Unit)
    }

    fun onSignOutEvent() {
        _signOutEvent.value = Event(Unit)
    }

    fun onDeleteLocationEvent() {
        _deleteLocationEvent.value = Event(Unit)
    }

    class MainViewModelFactory: ViewModelProvider.Factory {
        override fun <T : androidx.lifecycle.ViewModel> create(modelClass: Class<T>): T {
            return MainViewModel() as T
        }
    }
}