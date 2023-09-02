package com.viewpharm.yakal.main.view

import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemHomePillMainBinding
import com.viewpharm.yakal.main.viewmodel.HomeTodoViewModel
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.type.ETakingTime
import timber.log.Timber

class PillTodoAdapter(private val viewModel: HomeTodoViewModel) : RecyclerView.Adapter<PillTodoAdapter.ScheduleViewHolder>() {
    private val schedules:List<Schedule> = viewModel.schedules.value!!

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ScheduleViewHolder {
        return ScheduleViewHolder(
            ItemHomePillMainBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: ScheduleViewHolder, position: Int) {
        holder.bind(schedules[position])
    }

    override fun getItemCount(): Int = schedules.size

    inner class ScheduleViewHolder(private val binding : ItemHomePillMainBinding) :RecyclerView.ViewHolder(binding.root) {
        fun bind(schedule: Schedule) {
            binding.schedule = schedule

            if (schedule.eTakingTime == ETakingTime.INVISIBLE) {
                binding.takingScheduleLayout.visibility = View.INVISIBLE
                return
            }

            binding.todayTakingScheduleSubRecyclerView.apply {
                layoutManager = LinearLayoutManager(context)
                adapter = PillAdapter(schedule.pills, onOverlapItemCallBack)
                setHasFixedSize(true)
            }

            binding.takingScheduleMainTimeView.text = schedule.ETime.toString()
            binding.takingScheduleMainCountView.text = "${schedule.totalCnt.toString()}개"
            if (schedule.completed) {
                binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#2666F6"))
            }
            binding.takingScheduleMainCheckBox.isChecked = schedule.completed

            itemView.setOnClickListener {
                Timber.d("Item Click 이벤트 발생")
                schedule.isExpanded = if (!schedule.isExpanded) {
                    /*
                    확장되어 있지 않으므로 확장시킴
                    이미지 및 외곽선을 활성화 시키고, 확장 상태를 보여주는  View Visible 상태로 바꾼다.
                     */
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_on)
                    binding.takingScheduleLayout.setBackgroundResource(R.drawable.view_round_todo_on)
                    binding.activeExpandView.visibility = View.VISIBLE

                    /*
                    리사이클러 뷰를 View Visible 상태로 바꾸고, 확장 상태로 넣어준다.
                     */
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.VISIBLE
                    schedule.isExpanded.not()
                }else {
                    /*
                    확장되어 있으므로 축소시킴
                    이미지 및 외곽선을 비활성화 시키고, 확장 상태를 보여주는 View Gone 상태로 바꾼다.
                     */
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_off)
                    binding.takingScheduleLayout.setBackgroundResource(R.drawable.view_round_todo_off)
                    binding.activeExpandView.visibility = View.GONE

                    /*
                    리사이클러 뷰를 View Gone 상태로 바꾸고, 값에 축소 상태로 넣어준다.
                     */
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.GONE
                    schedule.isExpanded.not()
                }
            }


            binding.takingScheduleMainCheckBox.setOnClickListener {
                schedule.completed = if (schedule.completed) {
                    binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#C6C6CF"))
                    schedule.completed.not()
                } else {
                    binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#2666F6"))
                    schedule.completed.not()
                }
            }
        }
    }
}