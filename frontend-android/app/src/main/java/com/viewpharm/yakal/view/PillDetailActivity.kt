package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ActivityPillDetailBinding

class PillDetailActivity : AppCompatActivity() {
    private lateinit var binding: ActivityPillDetailBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityPillDetailBinding.inflate(layoutInflater)
        setContentView(binding.root)
        overridePendingTransition(R.anim.slide_from_right, R.anim.none)
    }

    override fun onStart() {
        _init()
        super.onStart()
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        finish()
        if (isFinishing) {
            overridePendingTransition(R.anim.none, R.anim.slide_to_right)
        }
    }

    private fun _init() {
        onCreateToolbar()
    }

    @SuppressLint("AppCompatMethod")
    private fun onCreateToolbar() {
        binding.toolbar.apply {
            actionBar?.hide()
            setSupportActionBar(this)
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.setDisplayShowTitleEnabled(false)
        }

        binding.toolbarTitle.text = "약 세부 정보"

        binding.toolbar.setNavigationOnClickListener {
            finish()
            overridePendingTransition(R.anim.none, R.anim.slide_to_right)
        }
    }
}