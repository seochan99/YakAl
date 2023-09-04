package com.viewpharm.yakal.main.fragment

import android.text.SpannableStringBuilder
import android.view.View
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.base.DefaultViewModel
import com.viewpharm.yakal.databinding.FragmentGoOutBinding
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.main.adapter.IndentLeadingMarginSpan

class GoOutFragment : BaseFragment<FragmentGoOutBinding, DefaultViewModel>(R.layout.fragment_go_out) {

    override val viewModel: DefaultViewModel by lazy {
        DefaultViewModel.DefaultViewModelFactory().create(DefaultViewModel::class.java)
    }

    override fun initView() {
        super.initView()
        binding.descriptionOneTextView.text = SpannableStringBuilder(binding.descriptionOneTextView.text).apply {
            setSpan(IndentLeadingMarginSpan(), 0, length, 0)
        }
        binding.descriptionTwoTextView.text = SpannableStringBuilder(binding.descriptionTwoTextView.text).apply {
            setSpan(IndentLeadingMarginSpan(), 0, length, 0)
        }
        binding.descriptionThreeTextView.text = SpannableStringBuilder(binding.descriptionThreeTextView.text).apply {
            setSpan(IndentLeadingMarginSpan(), 0, length, 0)
        }
        binding.descriptionFourTextView.text = SpannableStringBuilder(binding.descriptionFourTextView.text).apply {
            setSpan(IndentLeadingMarginSpan(), 0, length, 0)
        }
    }

    override fun initViewModel() {
        super.initViewModel()
    }

    override fun initListener(view: View) {
        super.initListener(view)
        binding.cancelButton.setOnClickListener {
            activity?.onBackPressed()
        }

        binding.goOutButton.setOnClickListener {
            (activity as MainActivity).viewModel.onToastEvent("회원탈퇴은 금지입니다")
            activity?.onBackPressed()
        }
    }
}