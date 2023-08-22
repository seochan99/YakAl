package com.viewpharm.yakal.signup.fragment

import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.AbsoluteSizeSpan
import android.text.style.StyleSpan
import android.view.View
import androidx.fragment.app.viewModels
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentSignUpModeBinding
import com.viewpharm.yakal.signup.viewmodel.NextEventViewModel
import com.viewpharm.yakal.signup.viewmodel.ModeViewModel
import com.viewpharm.yakal.type.EMode

class SignUpModeFragment : BaseFragment<FragmentSignUpModeBinding, ModeViewModel>(R.layout.fragment_sign_up_mode) {
    override val baseViewModel: ModeViewModel by viewModels {
        ModeViewModel.RadioViewModelFactory()
    }
    private val nextActionViewModel: NextEventViewModel by viewModels() {
        NextEventViewModel.ActionViewModelFactory()
    }
    private val safeArgs: SignUpModeFragmentArgs by navArgs()

    override fun initView() {
        super.initView()
        val titleText: String = "모드를 선택해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(android.graphics.Typeface.BOLD),
                    0,
                    2,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

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
                    StyleSpan(android.graphics.Typeface.BOLD),
                    8,
                    21,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.baseViewModel = baseViewModel
        binding.nextActionViewModel = nextActionViewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        baseViewModel.mode.observe(viewLifecycleOwner) {
        }

        nextActionViewModel.addScheduleEvent.observe(viewLifecycleOwner) {
            it.getContentIfNotHandled()?.let {
                Navigation.findNavController(view)
                    .navigate(
                        SignUpModeFragmentDirections.actionToSignUpFinishFragment(
                            safeArgs.birthday,
                            safeArgs.sex,
                            safeArgs.nickName,
                            baseViewModel.mode.value?.mode == EMode.DETAIL
                        )
                    )
            }
        }
    }
}