package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.repository.AuthRepository
import com.viewpharm.yakal.signup.UserInfoRequestDto
import kotlinx.coroutines.launch

class FinishViewModel(
    private val authRepository: AuthRepository
): BaseViewModel() {
    private val _event = MutableLiveData<Event<Unit>>()
    val event : LiveData<Event<Unit>> = _event

    private val _nextEnable = MutableLiveData<Boolean>()
    val nextEnable : LiveData<Boolean> = _nextEnable

    var eventTag : EventTag = EventTag.FAIL
        private set

    companion object {
        enum class EventTag {
            SUCCESS,
            NEXT,
            FAIL,
        }
    }

    init {
        _nextEnable.value = false
    }

    fun updateUserData(userInfoRequestDto: UserInfoRequestDto) {
        viewModelScope.launch {
            addDisposable(authRepository.postUserInfo(userInfoRequestDto).subscribe({
                if (it) {
                    eventTag = EventTag.SUCCESS
                    _nextEnable.value = true
                    _event.value = Event(Unit)
                } else {
                    eventTag = EventTag.FAIL
                    _nextEnable.value = false
                    _event.value = Event(Unit)
                }
            }, {
                it.printStackTrace()
            }))
        }
    }

    fun onClickNextButton() {
        eventTag = EventTag.NEXT
        _event.value = Event(Unit)
    }

    class FinishViewModelFactory(
        private val authRepository: AuthRepository
    ): ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return FinishViewModel(authRepository) as T
        }
    }
}