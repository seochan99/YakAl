package com.viewpharm.yakal.signup.fragment

import android.graphics.Typeface
import android.os.Bundle
import android.text.Editable
import android.text.InputFilter
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.TextWatcher
import android.text.style.StyleSpan
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentSignUpModeBinding
import com.viewpharm.yakal.databinding.FragmentSignUpNicknameBinding
import com.viewpharm.yakal.databinding.FragmentSignUpTermBinding
import com.viewpharm.yakal.signup.viewmodel.NextEventViewModel
import com.viewpharm.yakal.signup.viewmodel.NicknameViewModel
import com.viewpharm.yakal.signup.viewmodel.SignUpTermViewModel
import java.util.regex.Pattern


class SignUpNicknameFragment : BaseFragment<FragmentSignUpNicknameBinding, NicknameViewModel>(R.layout.fragment_sign_up_nickname) {
    private val safeArgs: SignUpNicknameFragmentArgs by navArgs()

    override val viewModel: NicknameViewModel by viewModels {
        NicknameViewModel.NicknameViewModelFactory()
    }

    override fun initView() {
        super.initView()

        val titleText: String = "약알에서 사용할\n닉네임을 입력해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    9,
                    12,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

        val filterSpace = InputFilter { source, _, _, _, _, _ ->
            viewModel.filterKorean(source)
        }

        binding.nicknameEditText.filters = arrayOf(filterSpace, InputFilter.LengthFilter(5))
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        viewModel.addScheduleEvent.observe(viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Navigation.findNavController(view)
                    .navigate(
                        SignUpNicknameFragmentDirections.actionToSignUpModeFragment(
                            safeArgs.birthday,
                            safeArgs.sex,
                            viewModel.nickname.value?.nickname.toString()
                        )
                    )
            }
        })

        viewModel.inputToastEvent.observe(viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Toast.makeText(context, "한글만 입력 가능합니다", Toast.LENGTH_SHORT).show()
            }
        })

        viewModel.buttonToastEvent.observe(viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Toast.makeText(context, "초성, 중성 입력이 존재합니다", Toast.LENGTH_SHORT).show()
            }
        })
    }
}