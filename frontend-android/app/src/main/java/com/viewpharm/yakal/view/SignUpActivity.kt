package com.viewpharm.yakal.view

import android.animation.ValueAnimator
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.navigation.NavController
import androidx.navigation.NavDestination
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.NavigationUI
import androidx.navigation.ui.setupWithNavController
import com.kakao.sdk.common.util.Utility
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ActivitySignUpBinding
import timber.log.Timber

class SignUpActivity : AppCompatActivity() {
    private lateinit var binding: ActivitySignUpBinding
    private lateinit var navController: NavController
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySignUpBinding.inflate(layoutInflater).apply {
            setContentView(root)
        }

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
            when (destination.id) {
                R.id.signUpTermFragment -> {
                    startProgressBarAnimation(0)
                }
                R.id.signUpCertificationFragment -> {
                    startProgressBarAnimation(25)
                }
                R.id.signUpNicknameFragment -> {
                    startProgressBarAnimation(50)
                }
                R.id.signUpModeFragment -> {
                    startProgressBarAnimation(75)
                }
                R.id.signUpFinishFragment -> {
                    startProgressBarAnimation(100)
                }
                else -> {
                    binding.signUpProgressBar.visibility = View.GONE
                }
            }
        }
        NavigationUI.setupActionBarWithNavController(this, navController)
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
}