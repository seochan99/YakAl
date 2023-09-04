package com.viewpharm.yakal.signup.fragment

import androidx.fragment.app.viewModels
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.base.DefaultViewModel
import com.viewpharm.yakal.databinding.FragmentSignUpTermDetailBinding
import com.viewpharm.yakal.type.ETerm
import com.viewpharm.yakal.signup.activity.SignUpActivity

class SignUpTermDetailFragment() : BaseFragment<FragmentSignUpTermDetailBinding, DefaultViewModel>(R.layout.fragment_sign_up_term_detail) {
    override val viewModel: DefaultViewModel by viewModels {
        DefaultViewModel.DefaultViewModelFactory()
    }
    private val safeArgs: SignUpTermDetailFragmentArgs by navArgs()

    override fun initView() {
        super.initView()
        (activity as SignUpActivity).setToolbarTitle(safeArgs.termType.toString())
        binding.termDetailTextView.text = when(safeArgs.termType) {
            ETerm.SERVICE -> getString(R.string.serviceTerms)
            ETerm.INFORMATION -> " 정보 탭 "
            ETerm.LOCATION -> " 위치 탭"
            ETerm.MARKETING -> " 마케팅 탭"
            else -> ""
        }
    }

    override fun onDestroyView() {
        (activity as SignUpActivity).setToolbarTitle("")
        super.onDestroyView()
    }
}