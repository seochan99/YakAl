package com.viewpharm.yakal.view

import android.animation.ValueAnimator
import android.os.Bundle
import android.view.View
import androidx.activity.OnBackPressedCallback
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ActivitySignUpBinding


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
                R.id.signUpTermFragment, R.id.signUpCertificationFragment,
                R.id.signUpNicknameFragment, R.id.signUpModeFragment ,
                R.id.signUpFinishFragment -> {
                    binding.signUpProgressBar.visibility = View.VISIBLE
                    binding.signUpTitleTextView.visibility = View.GONE

                    when(destination.id) {
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
                            binding.toolbar.animate()
                                .alpha(0.0f)
                                .setDuration(300)
                                .withEndAction(Runnable {
                                    binding.toolbar.visibility = View.INVISIBLE
                                })
                                .start()
                            startProgressBarAnimation(100)
                        }
                    }
                }
                else -> {
                    binding.signUpProgressBar.visibility = View.GONE
                    binding.signUpTitleTextView.visibility = View.VISIBLE
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

    override fun finish() {
        binding.signUpFrameLayout.animate()
            .alpha(0.0f)
            .setDuration(50)
            .start()
        navController.popBackStack(
            R.id.signUpTermFragment,
            true
        )
        super.finish()
    }
}