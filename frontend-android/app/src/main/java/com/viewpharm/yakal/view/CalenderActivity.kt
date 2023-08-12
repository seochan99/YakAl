package com.viewpharm.yakal.view

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.viewpharm.yakal.R
import com.viewpharm.yakal.adapter.CalendarAdapter
import com.viewpharm.yakal.adapter.PillTodoAdapter
import com.viewpharm.yakal.databinding.ActivityCalenderBinding
import com.viewpharm.yakal.model.Pill
import com.viewpharm.yakal.model.PillTodo
import com.viewpharm.yakal.type.ETakingTime
import com.viewpharm.yakal.ui.CalendarBottomDialog
import com.viewpharm.yakal.util.CalendarUtil
import java.time.LocalDate

class CalenderActivity : AppCompatActivity() {
    private lateinit var binding: ActivityCalenderBinding
    private var currentDate : LocalDate = LocalDate.now()
    private val pillTodos : List<PillTodo> = listOf(
        PillTodo(
            ETakingTime.MORNING, 3, false, false, listOf(
                Pill("1", false),
                Pill("2", true),
                Pill("3", false)
            )),
        PillTodo(
            ETakingTime.AFTERNOON, 2, false, false, listOf(
                Pill("1", true),
                Pill("2", true),
            )),
        PillTodo(
            ETakingTime.EVENING, 3, false, false, listOf(
                Pill("1", true),
                Pill("2", true),
                Pill("3", false)
            )),
        PillTodo(
            ETakingTime.DEFAULT, 3, false, false, listOf(
                Pill("1", true),
                Pill("2", false),
                Pill("3", false)
            )),
        PillTodo(
            ETakingTime.INVISIBLE, 0, true, true, listOf(
            )),
    )

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
        setTitleDateTextView()
        setTodayDateTextView()
        setPreviousButton()
        setNextButton()
        setTextBottomSheetButton()


        binding.calendarRecyclerView.apply {
            layoutManager = GridLayoutManager(context, 7)
            adapter = CalendarAdapter(currentDate, CalendarUtil.daysInWeekArray(currentDate))
            setHasFixedSize(true)
        }

        binding.todayTakingScheduleMainRecyclerView.apply {
            // 수직으로 출력
            layoutManager = LinearLayoutManager(context)

            // Data 관리
            adapter = PillTodoAdapter(pillTodos)

            // 리사이클러뷰의 크기가 변할 일이 없으므로,
            // 그럼 누구 새로 들어오거나 나갈때 아이템들의 자리만 다시 잡아준다. (리소스 최적화)
            setHasFixedSize(true)
        }
    }

    private fun setDateView() {
        setTitleDateTextView()
        setTodayDateTextView()

        binding.calendarRecyclerView.adapter?.let {
            (it as CalendarAdapter).setCalendarTakingList(currentDate, CalendarUtil.daysInWeekArray(currentDate))
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
    private fun setTitleDateTextView() {
        binding.monthTextView.text = CalendarUtil.getFormattedMonthFromDate(currentDate)
    }

    @SuppressLint("SimpleDateFormat")
    private fun setTodayDateTextView() {
        binding.todayDateTextView.text = CalendarUtil.getFormattedDayFromDate(currentDate)
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