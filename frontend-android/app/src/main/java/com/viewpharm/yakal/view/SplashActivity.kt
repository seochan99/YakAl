package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import com.viewpharm.yakal.R
import timber.log.Timber

@SuppressLint("CustomSplashScreen")
class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Timber.d("SplashActivity Create")
        setContentView(R.layout.activity_splash)

        Handler().postDelayed(Runnable {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }, 1000)
    }

    override fun onStop() {
        Timber.d("SplashActivity Stop")
        super.onStop()
        finish()
    }

    override fun onDestroy() {
        Timber.d("SplashActivity Destroy")
        super.onDestroy()
    }
}