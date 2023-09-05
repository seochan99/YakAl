package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel

class NotificationSettingViewModel: BaseViewModel() {
    private val _isOnTaking = MutableLiveData<Boolean>(true)
    val isOnTaking: LiveData<Boolean> = _isOnTaking


    class NotificationSettingViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return NotificationSettingViewModel() as T
        }
    }
}