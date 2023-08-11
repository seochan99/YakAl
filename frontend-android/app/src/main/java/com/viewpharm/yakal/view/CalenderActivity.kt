package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.viewpharm.yakal.R
import com.viewpharm.yakal.adapter.CalendarAdapter
import com.viewpharm.yakal.databinding.ActivityCalenderBinding
import com.viewpharm.yakal.ui.CalendarBottomDialog
import com.viewpharm.yakal.util.CalendarUtil
import java.time.LocalDate

class CalenderActivity : AppCompatActivity() {
    private lateinit var binding: ActivityCalenderBinding
    private var currentDate : LocalDate = LocalDate.now()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCalenderBinding.inflate(layoutInflater)
        setContentView(binding.root)
        overridePendingTransition(R.anim.slide_right_to_left, R.anim.none)

        _init()
    }



    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        finish()
        if (isFinishing) {
            overridePendingTransition(R.anim.none, R.anim.slide_left_to_right)
        }
    }

    private fun _init() {
        onCreateToolbar()
        setDateTextView()
        setPreviousButton()
        setNextButton()
        setTextBottomSheetButton()

        binding.calendarRecyclerView.apply {
            layoutManager = GridLayoutManager(context, 7)
            adapter = CalendarAdapter(CalendarUtil.daysInWeekArray(currentDate))
            setHasFixedSize(true)
        }
    }

    private fun setDateView() {
        setDateTextView()

        binding.calendarRecyclerView.adapter?.let {
            (it as CalendarAdapter).setCalendarTakingList(CalendarUtil.daysInWeekArray(currentDate))
            it.notifyItemRangeChanged(0, 7)
        }
    }

    @SuppressLint("AppCompatMethod")
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
            overridePendingTransition(R.anim.none, R.anim.slide_left_to_right)
        }
    }

    @SuppressLint("SimpleDateFormat")
    private fun setDateTextView() {
        binding.monthTextView.text = CalendarUtil.getFormattedDayFromDate(currentDate)
    }

    private fun setPreviousButton() {
        binding.previousButton.setOnClickListener {
            currentDate = currentDate.minusWeeks(1)
            setDateView();
        }
    }

    private fun setNextButton() {
        binding.nextButton.setOnClickListener {
            currentDate = currentDate.plusWeeks(1)
            setDateView();
        }
    }

    private fun setTextBottomSheetButton() {
        binding.monthTextView.setOnClickListener {
            CalendarBottomDialog(currentDate).also {
                it.show(supportFragmentManager, "CalendarBottomDialogFragment")
            }
        }
    }
}