package com.viewpharm.yakal.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ActivityNotificationBinding

class NotificationActivity : AppCompatActivity() {
    private lateinit var binding: ActivityNotificationBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityNotificationBinding.inflate(layoutInflater)
        setContentView(binding.root)

        overridePendingTransition(R.anim.from_right_to_left, R.anim.none)

        onCreateToolbar()
    }

    private fun onCreateToolbar() {
        binding.toolbar.apply {
            actionBar?.hide()
            setSupportActionBar(this)
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.setDisplayShowTitleEnabled(false)
        }

        binding.toolbarTitle.text = "알람"

        binding.toolbar.setNavigationOnClickListener {
            finish()
            overridePendingTransition(R.anim.none, R.anim.from_left_to_right)
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        finish()
        if (isFinishing) {
            overridePendingTransition(R.anim.none, R.anim.from_left_to_right)
        }
    }
}