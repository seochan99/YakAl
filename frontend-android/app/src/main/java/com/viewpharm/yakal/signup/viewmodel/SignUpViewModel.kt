package com.viewpharm.yakal.signup.viewmodel

import android.view.View
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseViewModel

class SignUpViewModel: BaseViewModel() {
    // isDetail, isFinish 해서 두개로 나누는게 좋을듯
    private val _percent = MutableLiveData<Int>()
    val percent: LiveData<Int> = _percent

    private val _isDetailed = MutableLiveData<Boolean>()
    val isDetailed: LiveData<Boolean> = _isDetailed

    private val _isFinished = MutableLiveData<Boolean>()
    val isFinished: LiveData<Boolean> = _isFinished

    init {
        _percent.value = 0
        _isDetailed.value = false
        _isFinished.value = false
    }

    fun addOnDestinationChanged(destinationId: Int) {
        when (destinationId) {
            R.id.signUpTermFragment, R.id.signUpCertificationFragment,
            R.id.signUpNicknameFragment, R.id.signUpModeFragment,
            R.id.signUpFinishFragment -> {
                _percent.value = when (destinationId) {
                    R.id.signUpTermFragment -> 0
                    R.id.signUpCertificationFragment -> 25
                    R.id.signUpNicknameFragment -> 50
                    R.id.signUpModeFragment -> 75
                    R.id.signUpFinishFragment -> 100
                    else -> _percent.value
                }

                _isDetailed.value = false

                _isFinished.value = R.id.signUpFinishFragment == destinationId
            }
            else -> {
                _isDetailed.value = true
            }
        }
    }

    class SignUpViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SignUpViewModel() as T
        }
    }
}