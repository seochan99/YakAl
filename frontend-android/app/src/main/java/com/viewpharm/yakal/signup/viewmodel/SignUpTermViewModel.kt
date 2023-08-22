package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.signup.model.TermAgreeState

class SignUpTermViewModel: BaseViewModel() {
    private val _agreeState = MutableLiveData<TermAgreeState>()
    val agreeState: LiveData<TermAgreeState> = _agreeState

    init {
        _agreeState.value = TermAgreeState()
    }

    fun onClickAllAgree() {
        _agreeState.value = if (_agreeState.value!!.isAllAgreed) {
            TermAgreeState()
        } else {
            TermAgreeState(
                isAllAgreed = true,
                isServiceAgreed = true,
                isLocationAgreed = true,
                isInformationAgreed = true,
                isMarketingAgreed = true,
                isEssentialAgreed = true
            )
        }
    }

    fun onClickServiceAgree() {
        _agreeState.value = _agreeState.value?.copy(isServiceAgreed = !_agreeState.value!!.isServiceAgreed)
        isAllAgree()
        isEssentialAgree()
    }

    fun onClickLocationAgree() {
        _agreeState.value = _agreeState.value?.copy(isLocationAgreed = !_agreeState.value!!.isLocationAgreed)
        isAllAgree()
        isEssentialAgree()
    }

    fun onClickInformationAgree() {
        _agreeState.value = _agreeState.value?.copy(isInformationAgreed = !_agreeState.value!!.isInformationAgreed)
        isAllAgree()
        isEssentialAgree()
    }

    fun onClickMarketingAgree() {
        _agreeState.value = _agreeState.value?.copy(isMarketingAgreed = !_agreeState.value!!.isMarketingAgreed)
        isAllAgree()
        isEssentialAgree()
    }

    private fun isEssentialAgree() {
        if (_agreeState.value!!.isEssentialAgree()) {
            _agreeState.value = _agreeState.value?.copy(isEssentialAgreed = true)
        } else {
            _agreeState.value = _agreeState.value?.copy(isEssentialAgreed = false)
        }
    }

    private fun isAllAgree() {
        if (_agreeState.value!!.isAllAgree()) {
            _agreeState.value = _agreeState.value?.copy(isAllAgreed = true)
        } else {
            _agreeState.value = _agreeState.value?.copy(isAllAgreed = false)
        }
    }


    class SignUpTermViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SignUpTermViewModel() as T
        }
    }
}