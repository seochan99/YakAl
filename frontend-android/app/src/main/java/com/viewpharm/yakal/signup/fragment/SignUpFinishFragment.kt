package com.viewpharm.yakal.signup.fragment

import android.annotation.SuppressLint
import android.graphics.Typeface
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.fragment.app.viewModels
import androidx.navigation.NavOptions
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.base.DefaultViewModel
import com.viewpharm.yakal.databinding.FragmentSignUpFinishBinding
import com.viewpharm.yakal.databinding.FragmentSignUpModeBinding
import com.viewpharm.yakal.repository.AuthRepository
import com.viewpharm.yakal.signup.UserInfoRequestDto
import com.viewpharm.yakal.signup.activity.SignUpActivity
import com.viewpharm.yakal.signup.viewmodel.FinishViewModel
import com.viewpharm.yakal.signup.viewmodel.ModeViewModel
import com.viewpharm.yakal.signup.viewmodel.NextEventViewModel
import com.viewpharm.yakal.signup.viewmodel.SignUpTermViewModel
import timber.log.Timber

class SignUpFinishFragment : BaseFragment<FragmentSignUpFinishBinding, FinishViewModel>(R.layout.fragment_sign_up_finish) {
    private val safeArgs: SignUpFinishFragmentArgs by navArgs()

    override val viewModel: FinishViewModel by viewModels {
        FinishViewModel.FinishViewModelFactory(AuthRepository(requireContext()))
    }

    @SuppressLint("SetTextI18n")
    override fun initView() {
        super.initView()
        val titleText: String = "${safeArgs.nickName}님\n회원가입이 완료되었습니다!"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    0,
                    safeArgs.nickName.length,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

        (activity as SignUpActivity).onBackPressedDispatcher.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
            }
        })

        viewModel.updateUserData(UserInfoRequestDto(
            name = safeArgs.nickName,
            isDetail = safeArgs.isDetail,
            birthday = safeArgs.birthday,
            sex = safeArgs.sex.toString(),
        ))
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)
        viewModel.event.observe(viewLifecycleOwner) {
            it.getContentIfNotHandled()?.let {
                when (viewModel.eventTag) {
                    FinishViewModel.Companion.EventTag.SUCCESS -> {
                        Toast.makeText(requireContext(), "회원가입이 완료되었습니다.", Toast.LENGTH_SHORT).show()
                    }
                    FinishViewModel.Companion.EventTag.FAIL -> {

                    }
                    FinishViewModel.Companion.EventTag.NEXT -> {
                        val navOptions: NavOptions = NavOptions.Builder()
                            .setPopUpTo(0, false)
                            .build()

                        Navigation.findNavController(view).navigate(
                            SignUpFinishFragmentDirections.actionToMainActivity(), navOptions
                        )

                        (activity as SignUpActivity).finish()
                    }
                }
            }
        }
    }
}