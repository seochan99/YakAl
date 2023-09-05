package com.viewpharm.yakal.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModel
import androidx.navigation.NavArgs

abstract class BaseFragment<T: ViewDataBinding, R: ViewModel>
    (@LayoutRes private val layoutId: Int): Fragment() {
    private var _binding: T? = null
    protected val binding: T get() = _binding!!

    abstract val viewModel: R

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = DataBindingUtil.inflate<T>(inflater, layoutId, container, false).also {
            it.lifecycleOwner = this
        }

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView()
        initViewModel()
        initListener(view)
        afterViewCreated(view)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    protected open fun initView() {}
    protected open fun initViewModel() {}
    protected open fun initListener(view: View) {}
    protected open fun afterViewCreated(view: View) {}
}