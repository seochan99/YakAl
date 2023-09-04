package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import com.viewpharm.yakal.R
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.signin.SignInActivity
import timber.log.Timber
import timber.log.Timber.Forest.plant

@SuppressLint("CustomSplashScreen")
class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        plant(Timber.DebugTree())
        super.onCreate(savedInstanceState)
        Timber.d("SplashActivity Create")
        setContentView(R.layout.activity_splash)

        Handler().postDelayed(Runnable {
            val intent = Intent(
                this,
                getSharedPreferences("token", MODE_PRIVATE).let {
                    if (it.getString("accessToken", null) == null || it.getString("refreshToken", null) == null) {
                        MainActivity::class.java
                    } else {
                        Timber.d("AccessToken: ${it.getString("accessToken", null)}" +
                                "\nRefreshToken: ${it.getString("refreshToken", null)}")
                        MainActivity::class.java
                    }
                })
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