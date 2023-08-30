package com.viewpharm.yakal.main.activity

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.widget.Toast
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.viewpharm.yakal.databinding.ActivityMainBinding
import timber.log.Timber

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var navController: NavController
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater).also {
            setContentView(it.root)
        }

        initView()
    }

    fun initView() {
        val navHostFragment:NavHostFragment = supportFragmentManager.findFragmentById(binding.mainFrameLayout.id) as NavHostFragment
        navController = navHostFragment.navController
        binding.bottomNavigationView.setupWithNavController(navController)
    }

    override fun onStart() {
        Timber.d("#1onStart")
        super.onStart()
    }

    fun displayToast(message: String) {
        Handler().postDelayed(Runnable {
            Toast.makeText(applicationContext, message, Toast.LENGTH_SHORT).show()
        }, 500)
    }

    fun onLogBackStack() {
        val backStackEntryCount = supportFragmentManager.backStackEntryCount
        Timber.i("현재 Back Stack Count: $backStackEntryCount")
        for (i in 0 until backStackEntryCount) {
            val backStackEntryAt = supportFragmentManager.getBackStackEntryAt(i)
            Timber.i("backStackEntryAt: $backStackEntryAt")
        }
    }
}