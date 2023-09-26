package com.viewpharm.yakal.signin

import android.widget.Toast
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.repository.AuthRepository
import com.viewpharm.yakal.signin.response.JwtValidEnum
import kotlinx.coroutines.launch
import timber.log.Timber

class SplashViewModel(
    private val authRepository: AuthRepository
): BaseViewModel() {
    companion object {
        enum class EventTag {
            LOAD_LOCAL_TOKEN,
            LOAD_TOKEN_VALID,
            LOAD_USER_VALID,
            FAIL_TOKEN_VALID,
            FAIL_USER_VALID,
            FAIL,
        }
    }
    private val _accessToken = MutableLiveData<String>()
    val accessToken: LiveData<String> = _accessToken
    private val _refreshToken = MutableLiveData<String>()
    val refreshToken: LiveData<String> = _refreshToken

    private val _inputEvent = MutableLiveData<Event<Unit>>()
    val inputEvent: LiveData<Event<Unit>> = _inputEvent

    var eventTag : EventTag = EventTag.FAIL
        private set

    init {
        addDisposable(authRepository.getJwtTokenInDevice().subscribe({
            _accessToken.value = it.accessToken
            _refreshToken.value = it.refreshToken
            _inputEvent.value = Event(Unit)
            eventTag = if (it.accessToken.isNotBlank() && it.refreshToken.isNotBlank()) EventTag.LOAD_LOCAL_TOKEN else EventTag.FAIL
        }, {
            it.printStackTrace()
        }))
    }

    fun isValidToken() {
        viewModelScope.launch {
            addDisposable(
                authRepository.isValidToken(accessToken.value!!)
                    .subscribe({
                        when(it.validity) {
                            JwtValidEnum.VALID -> {
                                eventTag = EventTag.LOAD_TOKEN_VALID
                                _inputEvent.value = Event(Unit)
                            }
                            JwtValidEnum.INVALID -> {
                                eventTag = EventTag.FAIL_TOKEN_VALID
                                _inputEvent.value = Event(Unit)
                            }
                            JwtValidEnum.EXPIRED -> {

                            }
                        }
            }, {
                it.printStackTrace()
            }))
        }
    }

    fun isValidUser() {
        viewModelScope.launch {
            addDisposable(
                authRepository.isValidUser(accessToken.value!!)
                    .subscribe({
                        if (it.isRegistered!!) {
                            eventTag = EventTag.LOAD_USER_VALID
                            _inputEvent.value = Event(Unit)
                        } else {
                            eventTag = EventTag.FAIL_USER_VALID
                            _inputEvent.value = Event(Unit)
                        }
                    }, {
                        it.printStackTrace()
                    }))
        }
    }

    class SplashViewModelFactory(
        private val authRepository: AuthRepository
    ) : ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SplashViewModel(authRepository) as T
        }
    }
}