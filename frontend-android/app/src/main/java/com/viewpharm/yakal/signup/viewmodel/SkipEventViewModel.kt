package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.event.AbstractEventViewModel

class SkipEventViewModel: AbstractEventViewModel() {
    fun onClickNextButton() {
        addScheduleEvent()
    }

    class SkipEventViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SkipEventViewModel() as T
        }
    }
}