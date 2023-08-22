package com.viewpharm.yakal.signup.fragment

import android.graphics.Typeface
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import android.view.View
import android.widget.Toast
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.base.DefaultViewModel
import com.viewpharm.yakal.databinding.FragmentSignUpCertificationBinding
import com.viewpharm.yakal.signup.viewmodel.NextEventViewModel
import com.viewpharm.yakal.signup.viewmodel.SkipEventViewModel
import com.viewpharm.yakal.type.ESex


class SignUpCertificationFragment: BaseFragment<FragmentSignUpCertificationBinding, SkipEventViewModel>(
    R.layout.fragment_sign_up_certification) {

    // 스킵 ViewModel 삭제 예정
    override val baseViewModel: SkipEventViewModel by viewModels {
        SkipEventViewModel.SkipEventViewModelFactory()
    }

    private val certificationViewModel: NextEventViewModel by viewModels() {
        NextEventViewModel.ActionViewModelFactory()
    }

    override fun initView() {
        super.initView()

        // 상단 세팅
        val titleText: String = "본인인증을 해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    0,
                    4,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.baseViewModel = baseViewModel
        binding.certificationViewModel = certificationViewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        baseViewModel.addScheduleEvent.observe(viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Navigation.findNavController(view)
                    .navigate(
                        SignUpCertificationFragmentDirections.actionToSignUpNicknameFragment(
                            "0000-00-00",
                            ESex.FEMALE
                        )
                    )
            }
        })

        certificationViewModel.addScheduleEvent.observe(viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Toast.makeText(context, "준비 중 입니다", Toast.LENGTH_SHORT).show()
            }
        })
    }
}