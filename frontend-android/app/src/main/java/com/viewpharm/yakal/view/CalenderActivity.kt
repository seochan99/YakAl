package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ActivityCalenderBinding
import com.viewpharm.yakal.ui.CalendarBottomDialogFragment
import timber.log.Timber
import java.text.SimpleDateFormat

class CalenderActivity : AppCompatActivity() {
    private lateinit var binding: ActivityCalenderBinding
    private var currentDateTime : Long = System.currentTimeMillis()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCalenderBinding.inflate(layoutInflater)
        setContentView(binding.root)

        overridePendingTransition(R.anim.from_right_to_left, R.anim.none)

        init()
    }



    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        finish()
        if (isFinishing) {
            overridePendingTransition(R.anim.none, R.anim.from_left_to_right)
        }
    }

    private fun init() {
        onCreateToolbar()
        setDateToday()
        setPreviousButton()
        setNextButton()
        setTextBottomSheetButton()
    }

    private fun onCreateToolbar() {
        binding.toolbar.apply {
            actionBar?.hide()
            setSupportActionBar(this)
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.setDisplayShowTitleEnabled(false)
        }

        binding.toolbarTitle.text = "다른 날짜 복약 정보"

        binding.toolbar.setNavigationOnClickListener {
            finish()
            overridePendingTransition(R.anim.none, R.anim.from_left_to_right)
        }
    }

    @SuppressLint("SimpleDateFormat")
    private fun setDateToday() {
        val todayFormat = SimpleDateFormat("yyyy년 MM월 dd일")
        binding.monthTextView.text = todayFormat.format(currentDateTime);
    }

    private fun setPreviousButton() {
        binding.previousButton.setOnClickListener {
            Timber.d("Previous Button Clicked")
        }
    }

    private fun setNextButton() {
        binding.nextButton.setOnClickListener {
            Timber.d("Next Button Clicked")
        }
    }

    private fun setTextBottomSheetButton() {
        binding.monthTextView.setOnClickListener {
            val calenderBottomDialogFragment : CalendarBottomDialogFragment = CalendarBottomDialogFragment().also {
                it.show(supportFragmentManager, "CalendarBottomDialogFragment")
            }
        }
    }

//    private fun setMonthView() {
//        binding.monthTextView.text = getYearToMonth()
//        var daysInMonth = mutableListOf<String>();
//    }
//
//    private fun getYearToMonth() : String {
//        return todayFormat.format(currentDateTime)
//    }
}