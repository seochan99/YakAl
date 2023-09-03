package com.viewpharm.yakal.main.fragment

import android.animation.ValueAnimator
import android.content.Intent
import android.graphics.Color
import android.view.View
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import com.viewpharm.yakal.view.CalenderActivity
import com.viewpharm.yakal.view.NotificationActivity
import com.viewpharm.yakal.main.adapter.PillParentAdapter
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentMainHomeBinding
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.viewmodel.HomeTodoViewModel
import com.viewpharm.yakal.type.ETakingTime

class MainHomeFragment : BaseFragment<FragmentMainHomeBinding, HomeTodoViewModel>(R.layout.fragment_main_home) {
     override val baseViewModel: HomeTodoViewModel by lazy {
         HomeTodoViewModel.TodoViewModelFactory().create(HomeTodoViewModel::class.java)
    }

    override fun initView() {
        setNotificationButtonClickEvent()
        setAnotherTakingLayoutClickEvent()

        (activity as MainActivity).onLogBackStack()
        binding.todayTakingScheduleMainRecyclerView.apply {
            // 수직으로 출력
            layoutManager = LinearLayoutManager(context)

            // Data 관리
            adapter = PillParentAdapter(baseViewModel.schedules.value!!,
                object : MainCallBack.ScheduleCallBack {
                    override fun onScheduleCheckButtonClick(eTakingTime: ETakingTime) {
                        baseViewModel.updateSchedule(eTakingTime)
                    }

                    override fun onClickItemView(eTakingTime: ETakingTime) {
                        baseViewModel.onClickScheduleItemView(eTakingTime)
                    }
                },
                object: MainCallBack.TodoCallBack {
                    override fun onTodoCheckButtonClick(eTakingTime: ETakingTime, todoId: Int) {
                        baseViewModel.updateTodo(eTakingTime, todoId)
                    }
                },
                object : MainCallBack.OverLapCallback {
                    override fun onOverLapCheckButtonClick() {
                        Toast.makeText(context, "Overlap Click", Toast.LENGTH_SHORT).show()
                    }
                }
            )

            // 리사이클러뷰의 크기가 변할 일이 없으므로,
            // 그럼 누구 새로 들어오거나 나갈때 아이템들의 자리만 다시 잡아준다. (리소스 최적화)
            setHasFixedSize(true)
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.baseViewModel = baseViewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        baseViewModel.addButtonEvent.observe(viewLifecycleOwner) {
            if (baseViewModel.isExpandedButton.value!!) {
                // 회색 처리
                binding.addPillGrayLayout.visibility = View.VISIBLE

                // 약 추가 버튼 보이게 설정
                binding.addDirectPillButton.show()
                binding.addGeneralPillButton.show()
                binding.addPrescriptionButton.show()

                // 추가 메인 버튼 축소 시키기 및 아이콘 바꾸기
                binding.addPillListButton.shrink().apply {
                    binding.addPillListButton.setIconResource(R.drawable.ic_custom_cancel)
                }
            } else {
                // 약 추가 버튼 안 보이게 설정
                binding.addDirectPillButton.hide()
                binding.addGeneralPillButton.hide()
                binding.addPrescriptionButton.hide()

                // 추가 메인 버튼 확대 시키기 및 아이콘 바꾸기
                binding.addPillListButton.extend()
                binding.addPillListButton.setIconResource(R.drawable.ic_custom_pill)

                // 회색 처리 해제
                binding.addPillGrayLayout.visibility = View.GONE
            }
        }

        baseViewModel.progress.observe(viewLifecycleOwner) {
            startProgressBarAnimation(it)

            if (it == 0) {
                binding.todayPercentTextView.setTextColor(Color.parseColor("#FFC1D2FF"))
            } else {
                binding.todayPercentTextView.setTextColor(Color.parseColor("#FF5588FD"))
            }

            binding.todayPercentTextView.text = "${it}%"
        }

        baseViewModel.schedules.observe(viewLifecycleOwner) {
//            (binding.todayTakingScheduleMainRecyclerView.adapter as PillParentAdapter).submitList(it)
        }
    }

    // 알람 버튼 이벤트
    private fun setNotificationButtonClickEvent() {
        binding.goNotificationButton.setOnClickListener {
            Intent(context, NotificationActivity::class.java).apply {
                startActivity(this)
            }
        }
    }

    // 다른 날짜 복약정보 버튼 이벤트
    private fun setAnotherTakingLayoutClickEvent() {
        binding.anotherTakingLayout.setOnClickListener {
            Intent(context, CalenderActivity::class.java).apply {
                startActivity(this)
            }
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