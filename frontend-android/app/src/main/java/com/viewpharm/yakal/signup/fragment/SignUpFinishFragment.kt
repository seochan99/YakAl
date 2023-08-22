package com.viewpharm.yakal.signup.fragment

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
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
import com.viewpharm.yakal.signup.activity.SignUpActivity
import com.viewpharm.yakal.signup.viewmodel.ModeViewModel
import com.viewpharm.yakal.signup.viewmodel.NextEventViewModel
import com.viewpharm.yakal.signup.viewmodel.SignUpTermViewModel
import timber.log.Timber

class SignUpFinishFragment : BaseFragment<FragmentSignUpFinishBinding, NextEventViewModel>(R.layout.fragment_sign_up_finish) {
    private val safeArgs: SignUpFinishFragmentArgs by navArgs()

    override val baseViewModel: NextEventViewModel by viewModels {
        NextEventViewModel.ActionViewModelFactory()
    }

    @SuppressLint("SetTextI18n")
    override fun initView() {
        super.initView()
        binding.titleTextView.text = "${safeArgs.nickName}님\n회원가입이 완료되었습니다!"

        (activity as SignUpActivity).onBackPressedDispatcher.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
            }
        })
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.baseViewModel = baseViewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)
        baseViewModel.addScheduleEvent.observe(viewLifecycleOwner) {
            it.getContentIfNotHandled()?.let {
                Timber.e("""
                    safeArgs.birthday: ${safeArgs.birthday}
                    safeArgs.sex: ${safeArgs.sex}
                    safeArgs.nickName: ${safeArgs.nickName}
                    safeArgs.isDetail: ${safeArgs.isDetail}
                    """)

                (activity as SignUpActivity).navigateToActivity()
            }
        }
    }
}