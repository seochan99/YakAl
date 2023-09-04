package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.signup.model.Modestate
import com.viewpharm.yakal.type.EMode

class ModeViewModel: BaseViewModel() {
    private val _mode = MutableLiveData<Modestate>()
    val mode: LiveData<Modestate> = _mode

    init {
        _mode.value = Modestate()
    }

    fun setOnCheckedChange(checkedId: Int) {
        when(checkedId) {
            R.id.normalModeRadioButton -> {
                _mode.value = _mode.value?.copy(mode = EMode.NORMAL, isNextEnable = true)
            }
            R.id.lightModeRadioButton -> {
                _mode.value = _mode.value?.copy(mode = EMode.DETAIL, isNextEnable = true)
            }
        }
    }

    class RadioViewModelFactory: androidx.lifecycle.ViewModelProvider.Factory {
        override fun <T : androidx.lifecycle.ViewModel> create(modelClass: Class<T>): T {
            return ModeViewModel() as T
        }
    }
}