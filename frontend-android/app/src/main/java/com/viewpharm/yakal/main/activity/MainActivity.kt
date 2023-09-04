package com.viewpharm.yakal.main.activity

import android.os.Handler
import android.view.View
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.NavigationUI
import androidx.navigation.ui.setupWithNavController
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseActivity
import com.viewpharm.yakal.databinding.ActivityMainBinding
import com.viewpharm.yakal.dialog.OverlapBottomDialog
import com.viewpharm.yakal.main.viewmodel.MainViewModel
import timber.log.Timber

class MainActivity : BaseActivity<ActivityMainBinding, MainViewModel>(R.layout.activity_main) {
    override val viewModel: MainViewModel by lazy {
        MainViewModel.MainViewModelFactory().create(MainViewModel::class.java)
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


        navController = (supportFragmentManager.findFragmentById(binding.mainFrameLayout.id) as NavHostFragment).navController

        navController.addOnDestinationChangedListener { _, destination, _ ->
            when (destination.id) {
                R.id.profileAppSettingFragment, R.id.goOutFragment -> {
                    binding.bottomNavigationView.visibility = View.GONE
                    binding.toolbar.visibility = View.VISIBLE

                    when (destination.id) {
                        R.id.profileAppSettingFragment -> setToolbarTitle("앱 설정")
                        R.id.goOutFragment -> setToolbarTitle("회원 탈퇴")
                    }
                }
                else -> {
                    binding.bottomNavigationView.visibility = View.VISIBLE
                    binding.toolbar.visibility = View.GONE
                }
            }
        }
        NavigationUI.setupActionBarWithNavController(this, navController)
        binding.bottomNavigationView.setupWithNavController(navController)
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener() {
        super.initListener()
        viewModel.overLapEvent.observe(this) {
            OverlapBottomDialog(listOf())
                .show(supportFragmentManager, OverlapBottomDialog.TAG)
        }

        viewModel.toastEvent.observe(this) {
            Handler().postDelayed(Runnable {
                Toast.makeText(applicationContext, viewModel.message, Toast.LENGTH_SHORT).show()
            }, 200)
        }

        viewModel.signOutEvent.observe(this) {
            Toast.makeText(applicationContext, "로그아웃", Toast.LENGTH_SHORT).show()
        }

        viewModel.deleteLocationEvent.observe(this) {
            Toast.makeText(applicationContext, "위치 삭제", Toast.LENGTH_SHORT).show()
        }

        viewModel.calendarEvent.observe(this) {
            Toast.makeText(applicationContext, "캘린더", Toast.LENGTH_SHORT).show()
        }
    }

    @Deprecated("Back Stack Count를 확인하기 위한 메소드")
    fun onLogBackStack() {
        val backStackEntryCount = supportFragmentManager.backStackEntryCount
        Timber.i("현재 Back Stack Count: $backStackEntryCount")
        for (i in 0 until backStackEntryCount) {
            val backStackEntryAt = supportFragmentManager.getBackStackEntryAt(i)
            Timber.i("backStackEntryAt: $backStackEntryAt")
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        return navController.navigateUp() || super.onSupportNavigateUp()
    }

    fun setToolbarTitle(title: String) {
        binding.signUpTitleTextView.text = title
    }
}