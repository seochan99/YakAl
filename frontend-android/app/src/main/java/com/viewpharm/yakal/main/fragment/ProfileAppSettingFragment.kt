package com.viewpharm.yakal.main.fragment

import android.graphics.Typeface
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.AbsoluteSizeSpan
import android.text.style.StyleSpan
import android.view.View
import android.widget.Toast
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentProfileAppSettingBinding
import com.viewpharm.yakal.dialog.LogOutDialog
import com.viewpharm.yakal.dialog.TimeSettingDialog
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.model.TakingTime
import com.viewpharm.yakal.main.viewmodel.ProfileAppSettingViewModel
import com.viewpharm.yakal.signup.fragment.SignUpCertificationFragmentDirections
import com.viewpharm.yakal.type.ESex
import com.viewpharm.yakal.type.ETakingTime
import timber.log.Timber
import java.time.LocalTime

class ProfileAppSettingFragment :
    BaseFragment<FragmentProfileAppSettingBinding, ProfileAppSettingViewModel>(R.layout.fragment_profile_app_setting) {

    override val viewModel: ProfileAppSettingViewModel by lazy {
        ProfileAppSettingViewModel.ProfileAppSettingViewModelFactory().create(ProfileAppSettingViewModel::class.java)
    }

    override fun initView() {
        super.initView()

        val normalModeText: String = "일반 모드\n\n약알의 일반적인 모드입니다"
        binding.normalModeRadioButton.text = normalModeText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    AbsoluteSizeSpan(24, true),
                    0,
                    6,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

        val lightModeText: String = "라이트 모드\n\n시니어를 위한 쉬운 모드입니다.\n다제약물 정보가 포함되어 있습니다."
        binding.lightModeRadioButton.text = lightModeText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    AbsoluteSizeSpan(24, true),
                    0,
                    7,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    8,
                    21,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        viewModel.buttonEvent.observe(this.viewLifecycleOwner){
            it.getContentIfNotHandled()?.let {
                when (viewModel.getButtonType()) {
                    ProfileAppSettingViewModel.Companion.ButtonType.MOONING -> {
                        TimeSettingDialog(
                            ETakingTime.MORNING,
                            viewModel.mooningTime
                            , object : MainCallBack.TimeSettingCallback {
                                override fun onTimeSettingButtonClick(takingTime: TakingTime) {
                                    viewModel.updateTime(ETakingTime.MORNING, takingTime)
                                }

                            }).apply {
                                isCancelable = false
                            }.show((activity as MainActivity).supportFragmentManager, TimeSettingDialog.TAG)
                    }
                    ProfileAppSettingViewModel.Companion.ButtonType.AFTERNOON -> {
                        TimeSettingDialog(
                            ETakingTime.AFTERNOON,
                            viewModel.afternoonTime
                            , object : MainCallBack.TimeSettingCallback {
                                override fun onTimeSettingButtonClick(takingTime: TakingTime) {
                                    viewModel.updateTime(ETakingTime.AFTERNOON, takingTime)
                                }

                            }).apply {
                            isCancelable = false
                        }.show((activity as MainActivity).supportFragmentManager, TimeSettingDialog.TAG)
                    }
                    ProfileAppSettingViewModel.Companion.ButtonType.EVENING -> {
                        TimeSettingDialog(
                            ETakingTime.EVENING,
                            viewModel.eveningTime
                            , object : MainCallBack.TimeSettingCallback {
                                override fun onTimeSettingButtonClick(takingTime: TakingTime) {
                                    viewModel.updateTime(ETakingTime.EVENING, takingTime)
                                }

                            }).apply {
                            isCancelable = false
                        }.show((activity as MainActivity).supportFragmentManager, TimeSettingDialog.TAG)
                    }
                    ProfileAppSettingViewModel.Companion.ButtonType.LOGOUT -> {
                        LogOutDialog(object : MainCallBack.LogOutCallback {
                            override fun onLogOutButtonClick() {
                                (activity as MainActivity).viewModel.onToastEvent("로그아웃은 금지입니다")
                            }
                        }).apply {
                            isCancelable = false
                        }.show((activity as MainActivity).supportFragmentManager, LogOutDialog.TAG)
                    }
                    ProfileAppSettingViewModel.Companion.ButtonType.GO_OUT -> {
                        Navigation.findNavController(view)
                            .navigate(
                                ProfileAppSettingFragmentDirections.actionProfileAppSettingFragmentToGoOutFragment()
                            )
                    }
                    else -> Timber.d("알 수 없는 버튼")
                }
            }
        }
    }
}