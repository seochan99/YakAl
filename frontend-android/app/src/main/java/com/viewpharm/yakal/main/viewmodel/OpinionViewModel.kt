package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.main.model.OpinionState

class OpinionViewModel: BaseViewModel() {

    private val _opinionState = MutableLiveData<OpinionState>()
    val opinionState: LiveData<OpinionState> = _opinionState

    init {
        _opinionState.value = OpinionState()
    }

    fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
        _opinionState.value = _opinionState.value?.copy(sendEnable = s.isNotEmpty())
    }

    class RequestViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return OpinionViewModel() as T
        }
    }
}