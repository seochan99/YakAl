package com.viewpharm.yakal.base

import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.lifecycle.ViewModel
import timber.log.Timber

abstract class BaseActivity<T: ViewDataBinding, R: ViewModel>
    (@LayoutRes private val layoutId: Int): AppCompatActivity() {
    protected lateinit var binding: T
    abstract val viewModel: R

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView<T>(this, layoutId).also {
            it.lifecycleOwner = this
            setContentView(it.root)
        }

        initView()
        initViewModel()
        initListener()
        afterOnCreate()
    }

    protected open fun initView() {}
    protected open fun initViewModel() {}
    protected open fun initListener() {}
    protected open fun afterOnCreate() {}
}