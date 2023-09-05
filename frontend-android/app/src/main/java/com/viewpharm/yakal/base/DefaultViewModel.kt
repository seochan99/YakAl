package com.viewpharm.yakal.base

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

class DefaultViewModel: BaseViewModel() {
    class DefaultViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return DefaultViewModel() as T
        }
    }
}