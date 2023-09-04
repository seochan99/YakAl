package com.viewpharm.yakal.dialog

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.main.model.TakingTime

class TimeViewModel: BaseViewModel() {
    private val _time = MutableLiveData<TakingTime>()
    val time:LiveData<TakingTime> = _time

    fun setStartTime(startTime: TakingTime) {
        _time.value = _time.value?.copy(startTime = startTime.startTime)
    }

    fun setEndTime(endTime: TakingTime) {
        _time.value = _time.value?.copy(endTime = endTime.endTime)
    }

    class TimeViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return TimeViewModel() as T
        }
    }
}