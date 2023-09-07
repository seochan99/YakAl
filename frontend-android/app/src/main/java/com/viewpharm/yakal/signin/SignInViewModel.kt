package com.viewpharm.yakal.signin

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.repository.OAuth2Repository
import com.viewpharm.yakal.repository.AuthRepository

class SignInViewModel(
    private val authRepository: AuthRepository,
    private val oAuth2Repository: OAuth2Repository,
): BaseViewModel() {
    companion object {
        enum class EventTag {
            LOAD_GOOGLE_TOKEN,
            LOAD_REMOTE_TOKEN,
            FAIL
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

    fun signInWithGoogle(accessToken: String) {
    }

    fun signInWithKakao(accessToken: String) {
        addDisposable(authRepository.getTokenInRemoteByKakao(accessToken)
            .subscribe({
                eventTag = EventTag.LOAD_REMOTE_TOKEN
                _accessToken.value = it.accessToken
                _refreshToken.value = it.refreshToken
                _inputEvent.value = Event(Unit)
            }, {
                it.printStackTrace()
            }))
    }

    fun saveJwtInDevice() {
        authRepository.setJwtTokenInDevice(accessToken.value!!, refreshToken.value!!)
    }

    class SignInViewModelFactory(
        private val authRepository: AuthRepository,
        private val oAuth2Repository: OAuth2Repository
    ):  ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return SignInViewModel(authRepository, oAuth2Repository) as T
        }
    }
}