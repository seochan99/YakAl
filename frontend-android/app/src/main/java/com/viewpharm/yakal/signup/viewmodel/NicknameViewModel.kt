package com.viewpharm.yakal.signup.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.event.AbstractEventViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.signup.model.NicknameState
import java.util.regex.Pattern

class NicknameViewModel: AbstractEventViewModel() {
    private val _buttonToastEvent = MutableLiveData<Event<Unit>>()
    val buttonToastEvent: LiveData<Event<Unit>> = _buttonToastEvent

    private val _inputToastEvent = MutableLiveData<Event<Unit>>()
    val inputToastEvent: LiveData<Event<Unit>> = _inputToastEvent

    private val _nickname = MutableLiveData<NicknameState>()
    val nickname: LiveData<NicknameState> = _nickname

    init {
        _nickname.value = NicknameState()
    }

    fun onClickNext() {
        val pattern: Pattern = Pattern.compile("^[가-힣]+$")
        if (pattern.matcher(_nickname.value?.nickname.toString()).matches()) {
            addScheduleEvent()
        } else {
            addButtonToastEvent()
        }
    }

    fun filterKorean(source: CharSequence): CharSequence {
        val ps: Pattern = Pattern.compile("^[ㄱ-ㅣ가-힣]+$")
        return if (ps.matcher(source).matches() || source == "" || source.isEmpty()) {
            source
        } else {
            addInputToastEvent()
            ""
        }
    }

    fun onClickClear() {
        _nickname.value = _nickname.value?.copy(nickname = "")
        _nickname.value = _nickname.value?.copy(cancelEnable = false)
        _nickname.value = _nickname.value?.copy(nextEnable = false)
    }

    fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
        _nickname.value = _nickname.value?.copy(cancelEnable = s.isNotEmpty())
        _nickname.value = _nickname.value?.copy(nextEnable = s.isNotEmpty())
    }

    private fun addButtonToastEvent() {
        _buttonToastEvent.value = Event(Unit)
    }

    private fun addInputToastEvent() {
        _inputToastEvent.value = Event(Unit)
    }

    class NicknameViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return NicknameViewModel() as T
        }
    }
}