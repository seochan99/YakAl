package com.viewpharm.yakal.main.activity

import android.animation.ValueAnimator
import android.graphics.Color
import androidx.activity.OnBackPressedCallback
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseActivity
import com.viewpharm.yakal.databinding.ActivityCalenderBinding
import com.viewpharm.yakal.main.adapter.CalendarAdapter
import com.viewpharm.yakal.main.adapter.PillParentAdapter
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.viewmodel.CalendarViewModel
import com.viewpharm.yakal.main.viewmodel.HomeTodoViewModel
import com.viewpharm.yakal.type.ETakingTime
import java.time.LocalDate

class CalenderActivity : BaseActivity<ActivityCalenderBinding, CalendarViewModel>(R.layout.activity_calender) {

    override val viewModel: CalendarViewModel by lazy {
        CalendarViewModel.CalendarViewModelFactory().create(CalendarViewModel::class.java)
    }

    private val todoViewModel: HomeTodoViewModel by lazy {
        HomeTodoViewModel.TodoViewModelFactory().create(HomeTodoViewModel::class.java)
    }

    override fun initView() {
        super.initView()

        this.onBackPressedDispatcher.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                finish()
                if (isFinishing) {
                    overridePendingTransition(R.anim.slide_from_left, R.anim.slide_to_right)
                }
            }
        })

        binding.todayTakingScheduleMainRecyclerView.apply {
            // 수직으로 출력
            layoutManager = LinearLayoutManager(context)

            // Data 관리
            adapter = PillParentAdapter(todoViewModel.schedules.value!!,
                object : MainCallBack.ScheduleCallBack {
                    override fun onTodoCheckButtonClick(eTakingTime: ETakingTime) {
                        todoViewModel.updateSchedule(eTakingTime)
                    }

                    override fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId: Int) {
                        todoViewModel.updateTodo(eTakingTime, todoId)
                    }

                    override fun onClickItemView(eTakingTime: ETakingTime) {
                        todoViewModel.onClickScheduleItemView(eTakingTime)
                    }
                },
                object: MainCallBack.TodoCallBack {
                    override fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId: Int) {
                        todoViewModel.updateTodo(eTakingTime, todoId)
                    }
                },
                object : MainCallBack.OverLapCallback {
                    override fun onOverLapCheckButtonClick(pillTodos: List<PillTodo>) {
                    }
                }
            )

            animation = null // 애니메이션 제거

            // 리사이클러뷰의 크기가 변할 일이 없으므로,
            // 그럼 누구 새로 들어오거나 나갈때 아이템들의 자리만 다시 잡아준다. (리소스 최적화)
            setHasFixedSize(true)
        }

        binding.toolbar.setNavigationOnClickListener {
            onBackPressedDispatcher.onBackPressed()
        }

        binding.calendarRecyclerView.apply {
            layoutManager = GridLayoutManager(context, 7)
            adapter = CalendarAdapter(viewModel.calendarTakings.value!!,
                object:MainCallBack.CalendarCallback {
                    override fun onCalendarButtonClick(date: LocalDate) {
                        todoViewModel.updateDate(date)
                        viewModel.updateSelectedDate(date)
                    }
                })
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
        binding.todoViewModel = todoViewModel
    }

    override fun initListener() {
        super.initListener()
        binding.previousButton.setOnClickListener {
            viewModel.previousDate()
        }

        binding.nextButton.setOnClickListener {
            viewModel.nextDate()
        }

        viewModel.calendarTakings.observe(this) {
            if (viewModel.isChange) {
                (binding.calendarRecyclerView.adapter as CalendarAdapter).submitList(it)
                viewModel.updateIsChange()
            } else {
                if (!viewModel.isExpanded) {
                    (binding.calendarRecyclerView.adapter as CalendarAdapter).submitList(null)
                }
                (binding.calendarRecyclerView.adapter as CalendarAdapter).submitList(it)
            }

        }

        todoViewModel.progress.observe(this) {
            startProgressBarAnimation(it)

            if (it == 0) {
                binding.todayPercentTextView.setTextColor(Color.parseColor("#FFC1D2FF"))
            } else {
                binding.todayPercentTextView.setTextColor(Color.parseColor("#FF5588FD"))
            }

            binding.todayPercentTextView.text = "${it}%"
        }

        todoViewModel.schedules.observe(this) {
            (binding.todayTakingScheduleMainRecyclerView.adapter as PillParentAdapter).submitList(it)
        }
    }

    private fun startProgressBarAnimation(input: Int) {
        val animator = ValueAnimator.ofInt(binding.todayPercentBar.progress , input)
        animator.duration = 220 // 애니메이션의 지속 시간 설정 (밀리초)
        animator.addUpdateListener { animation ->
            val animatedValue = animation.animatedValue as Int
            binding.todayPercentBar.progress = animatedValue
        }
        animator.start()
    }
}