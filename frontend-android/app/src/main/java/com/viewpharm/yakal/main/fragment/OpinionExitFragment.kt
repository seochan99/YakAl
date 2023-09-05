package com.viewpharm.yakal.main.fragment

import android.view.View
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.base.DefaultViewModel
import com.viewpharm.yakal.databinding.FragmentOpinionExitBinding
import com.viewpharm.yakal.main.activity.MainActivity

class OpinionExitFragment : BaseFragment<FragmentOpinionExitBinding, DefaultViewModel>(R.layout.fragment_opinion_exit) {
    override val viewModel: DefaultViewModel by lazy {
        DefaultViewModel.DefaultViewModelFactory().create(DefaultViewModel::class.java)
    }

    override fun initListener(view: View) {
        super.initListener(view)
        binding.exitButton.setOnClickListener{
            (activity as MainActivity).onBackPressed()
        }
    }
}