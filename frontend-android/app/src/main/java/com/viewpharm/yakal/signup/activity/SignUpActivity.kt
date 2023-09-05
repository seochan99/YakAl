package com.viewpharm.yakal.signup.activity

import android.animation.ValueAnimator
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.view.View
import androidx.activity.OnBackPressedCallback
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModel
import androidx.navigation.NavController
import androidx.navigation.NavOptions
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseActivity
import com.viewpharm.yakal.databinding.ActivitySignUpBinding
import com.viewpharm.yakal.signup.viewmodel.SignUpViewModel
import timber.log.Timber


class SignUpActivity : BaseActivity<ActivitySignUpBinding, SignUpViewModel>(R.layout.activity_sign_up) {
    override val viewModel: SignUpViewModel by viewModels {
        SignUpViewModel.SignUpViewModelFactory()
    }
    private lateinit var navController: NavController

    override fun initView() {
        super.initView()
        setSupportActionBar(binding.toolbar).apply {
            supportActionBar?.setDisplayShowTitleEnabled(false)
        }

        this.onBackPressedDispatcher.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                onSupportNavigateUp()
            }
        })

        val navHostFragment = supportFragmentManager.findFragmentById(binding.signUpFrameLayout.id) as NavHostFragment
        navController = navHostFragment.navController
        navController.addOnDestinationChangedListener { _, destination, _ ->
            viewModel.addOnDestinationChanged(destination.id)
        }
        NavigationUI.setupActionBarWithNavController(this, navController)
    }
    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener() {
        super.initListener()

        // percent가 변경될 때마다 progressBar의 progress를 변경
        viewModel.percent.observe(this) {
            startProgressBarAnimation(it)
        }

        // DetailScreen 따라서 progressBar와 titleTextView의 visibility를 변경
        viewModel.isDetailed.observe(this) {
            binding.signUpProgressBar.visibility = if (it) View.GONE else View.VISIBLE
            binding.signUpTitleTextView.visibility = if (it) View.VISIBLE else View.GONE
        }

        // FinishScreen 이면 toolbar를 숨기고 progressBar를 100으로 변경
        viewModel.isFinished.observe(this) {
            if (it) {
                supportActionBar?.setDisplayHomeAsUpEnabled(false)
                binding.toolbar.animate()
                    .alpha(0.0f)
                    .setDuration(300)
                    .withEndAction(Runnable {
                        binding.toolbar.visibility = View.INVISIBLE
                    })
                    .start()
                startProgressBarAnimation(100)
            } else {
                supportActionBar?.setDisplayHomeAsUpEnabled(true)
                binding.toolbar.visibility = View.VISIBLE
            }
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        return navController.navigateUp() || super.onSupportNavigateUp()
    }

    private fun startProgressBarAnimation(input: Int) {
        val animator = ValueAnimator.ofInt(binding.signUpProgressBar.progress , input)
        animator.duration = 220 // 애니메이션의 지속 시간 설정 (밀리초)
        animator.addUpdateListener { animation ->
            val animatedValue = animation.animatedValue as Int
            binding.signUpProgressBar.progress = animatedValue
        }
        animator.start()
    }

    fun setToolbarTitle(title: String) {
        binding.signUpTitleTextView.text = title
    }
}