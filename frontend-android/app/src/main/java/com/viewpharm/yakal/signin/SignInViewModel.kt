package com.viewpharm.yakal.signin

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel

class SignInViewModel: BaseViewModel() {
    private

    class SignInViewModelFactory:  ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SignInViewModel() as T
        }
    }
}