package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.event.AbstractEventViewModel
import com.viewpharm.yakal.type.ETerm

class DetailEventViewModel: AbstractEventViewModel() {
    var termType: ETerm = ETerm.NONE
        private set

    fun onClickServiceTerm() {
        termType = ETerm.SERVICE
        addScheduleEvent()
    }

    fun onClickLocationTerm() {
        termType = ETerm.LOCATION
        addScheduleEvent()
    }

    fun onClickInformationTerm() {
        termType = ETerm.INFORMATION
        addScheduleEvent()
    }

    fun onClickMarketingTerm() {
        termType = ETerm.MARKETING
        addScheduleEvent()
    }

    class DetailEventViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return DetailEventViewModel() as T
        }
    }
}