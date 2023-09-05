package com.viewpharm.yakal.main.fragment

import android.graphics.Typeface
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import android.view.View
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentOpinionBinding
import com.viewpharm.yakal.main.viewmodel.OpinionViewModel

class OpinionFragment : BaseFragment<FragmentOpinionBinding, OpinionViewModel>(R.layout.fragment_opinion) {
    override val viewModel: OpinionViewModel by lazy {
        OpinionViewModel.RequestViewModelFactory().create(OpinionViewModel::class.java)
    }

    override fun initView() {
        super.initView()

        val titleText: String = "더 나은 약알을 위해\n소중한 의견을 남겨주세요!"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    12,
                    18,
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

        binding.nextButton.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(OpinionFragmentDirections.actionRequestFragmentToOpinionExitFragment())
        }
    }
}