package com.viewpharm.yakal.main.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.viewpharm.yakal.base.BaseViewModel
import com.viewpharm.yakal.event.Event
import com.viewpharm.yakal.main.model.TakingTime
import com.viewpharm.yakal.type.ETakingTime
import java.time.LocalTime

class ProfileAppSettingViewModel: BaseViewModel() {
    companion object {
        enum class ButtonType {
            MOONING,
            AFTERNOON,
            EVENING,
            LOGOUT,
            GO_OUT,
            UNKNOWN,
        }
    }

    private val _buttonEvent = MutableLiveData<Event<Unit>>()
    val buttonEvent: LiveData<Event<Unit>> = _buttonEvent
    private var buttonType: ButtonType = ButtonType.UNKNOWN

    private val _isDetail = MutableLiveData<Boolean>(false)
    val isDetail: LiveData<Boolean> = _isDetail

    private val _mooningTimeText = MutableLiveData<String>()
    val mooningTimeText: LiveData<String> = _mooningTimeText

    private val _afternoonTimeText = MutableLiveData<String>()
    val afternoonTimeText: LiveData<String> = _afternoonTimeText

    private val _eveningTimeText = MutableLiveData<String>()
    val eveningTimeText: LiveData<String> = _eveningTimeText

    var mooningTime: TakingTime = TakingTime(LocalTime.of(7, 0), LocalTime.of(8, 0))
        private set
    var afternoonTime: TakingTime = TakingTime(LocalTime.of(12, 0), LocalTime.of(13, 0))
        private set
    var eveningTime: TakingTime = TakingTime(LocalTime.of(18, 0), LocalTime.of(19, 0))
        private set

    init {
        _mooningTimeText.value = mooningTime.toString()
        _afternoonTimeText.value = afternoonTime.toString()
        _eveningTimeText.value = eveningTime.toString()
    }

    fun updateTime(eTakingTime: ETakingTime, takingTime: TakingTime) {
        when (eTakingTime) {
            ETakingTime.MORNING -> {
                mooningTime = takingTime
                _mooningTimeText.value = mooningTime.toString()
            }
            ETakingTime.AFTERNOON -> {
                afternoonTime = takingTime
                _afternoonTimeText.value = afternoonTime.toString()
            }
            ETakingTime.EVENING -> {
                eveningTime = takingTime
                _eveningTimeText.value = eveningTime.toString()
            }
            else -> {
            }
        }
    }

    fun getButtonType(): ButtonType = buttonType

    fun onClickMooningButton() {
        buttonType = ButtonType.MOONING
        _buttonEvent.value = Event(Unit)
    }

    fun onClickAfternoonButton() {
        buttonType = ButtonType.AFTERNOON
        _buttonEvent.value = Event(Unit)
    }

    fun onClickEveningButton() {
        buttonType = ButtonType.EVENING
        _buttonEvent.value = Event(Unit)
    }

    fun onClickLogoutButton() {
        buttonType = ButtonType.LOGOUT
        _buttonEvent.value = Event(Unit)
    }

    fun onClickGoOutButton() {
        buttonType = ButtonType.GO_OUT
        _buttonEvent.value = Event(Unit)
    }


    class ProfileAppSettingViewModelFactory: ViewModelProvider.Factory {
        override fun <T : ViewModel> create(modelClass: Class<T>): T {
            return ProfileAppSettingViewModel() as T
        }
    }
}