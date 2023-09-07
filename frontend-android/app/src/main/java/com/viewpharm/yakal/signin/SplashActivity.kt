package com.viewpharm.yakal.signin

import android.annotation.SuppressLint
import android.content.Intent
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseActivity
import com.viewpharm.yakal.databinding.ActivitySplashBinding
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.repository.AuthRepository
import com.viewpharm.yakal.signup.activity.SignUpActivity
import timber.log.Timber

@SuppressLint("CustomSplashScreen")
class SplashActivity : BaseActivity<ActivitySplashBinding, SplashViewModel>(R.layout.activity_splash){
    override val viewModel: SplashViewModel by lazy {
        SplashViewModel.SplashViewModelFactory(
            AuthRepository(context = this),
        ).create(SplashViewModel::class.java)
    }

    override fun initView() {
        Timber.plant(Timber.DebugTree())
        super.initView()
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener() {
        super.initListener()
        viewModel.inputEvent.observe(this) { event ->
            event.getContentIfNotHandled()?.let {
                when(viewModel.eventTag) {
                    SplashViewModel.Companion.EventTag.LOAD_LOCAL_TOKEN -> {
                        viewModel.isValidToken()
                    }
                    SplashViewModel.Companion.EventTag.LOAD_TOKEN_VALID -> {
                        viewModel.isValidUser()
                    }
                    SplashViewModel.Companion.EventTag.LOAD_USER_VALID -> {
                        startActivity(Intent(this@SplashActivity, MainActivity::class.java))
                    }
                    SplashViewModel.Companion.EventTag.FAIL_TOKEN_VALID,
                    SplashViewModel.Companion.EventTag.FAIL -> {
                        startActivity(Intent(this@SplashActivity, SignInActivity::class.java))
                    }
                    SplashViewModel.Companion.EventTag.FAIL_USER_VALID -> {
                        startActivity(Intent(this@SplashActivity, SignUpActivity::class.java))
                    }
                }
            }
        }
    }

    override fun onStop() {
        super.onStop()
        finish()
    }
}