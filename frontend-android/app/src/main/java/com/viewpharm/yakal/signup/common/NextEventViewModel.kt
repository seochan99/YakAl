package com.viewpharm.yakal.signup.common

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.event.AbstractEventViewModel

class NextEventViewModel: AbstractEventViewModel() {
    fun onClickNextButton() {
        addScheduleEvent()
    }

    class ActionViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return NextEventViewModel() as T
        }
    }
}