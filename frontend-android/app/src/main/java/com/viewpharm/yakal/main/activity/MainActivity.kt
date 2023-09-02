package com.viewpharm.yakal.main.activity

import android.os.Bundle
import android.os.Handler
import android.widget.Toast
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
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
        navController = (supportFragmentManager.findFragmentById(binding.mainFrameLayout.id) as NavHostFragment).navController
        binding.bottomNavigationView.setupWithNavController(navController)
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener() {
        super.initListener()
        viewModel.overLapEvent.observe(this) {
            OverlapBottomDialog(viewModel.pills)
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
}