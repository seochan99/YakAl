package com.viewpharm.yakal.main.adapter

import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemHomePillMainBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.activity.ScheduleDiffUtil
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.type.ETakingTime

class PillParentAdapter(
    private val schedules :List<Schedule>,
    private val scheduleCallBack: MainCallBack.ScheduleCallBack,
    private val todoCallBack: MainCallBack.TodoCallBack,
    private val onOverlapItemCallBack: MainCallBack.OverLapCallback?,)
    : ListAdapter<Schedule, PillParentAdapter.PillParentViewHolder>(ScheduleDiffUtil) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PillParentViewHolder {
        return PillParentViewHolder(
            ItemHomePillMainBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: PillParentViewHolder, position: Int) {
        holder.bind(schedules[position])
    }

    override fun getItemCount(): Int = schedules.size

    override fun getItemViewType(position: Int): Int {
        return position
    }

    private fun isAnyTodoExpanded(position: Int) {
        val temp = schedules.indexOfFirst { it.isExpanded }

        if (temp >= 0 && temp != position) {
            schedules[temp].isExpanded = false
            notifyItemChanged(temp)
        }
    }

    inner class PillParentViewHolder(val binding : ItemHomePillMainBinding) :RecyclerView.ViewHolder(binding.root) {
        fun bind(schedule: Schedule) {
            binding.schedule = schedule
            if (schedule.eTakingTime == ETakingTime.INVISIBLE) {
                binding.takingScheduleMainCardView.visibility = View.INVISIBLE
                return
            } else {
                binding.todayTakingScheduleSubRecyclerView.apply {
                    layoutManager = LinearLayoutManager(context)
                    adapter = PillChildrenAdapter(schedule.eTakingTime, schedule.todos, todoCallBack, onOverlapItemCallBack)
                    setHasFixedSize(true)
                }

                if (schedule.isExpanded) {
                    binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FF2666F6")
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_on)
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.VISIBLE
                    binding.activeExpandView.visibility = View.VISIBLE
                } else {
                    binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FFC6C6CF")
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_off)
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.GONE
                    binding.activeExpandView.visibility = View.GONE
                }
            }

            binding.takingScheduleLayout.setOnClickListener {
                isAnyTodoExpanded(adapterPosition)
                schedule.isExpanded = if (schedule.isExpanded) {
                    binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FFC6C6CF")
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_on)
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.VISIBLE
                    binding.activeExpandView.visibility = View.VISIBLE
                    schedule.isExpanded.not()
                } else {
                    binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FF2666F6")
                    binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_off)
                    binding.todayTakingScheduleSubRecyclerView.visibility = View.GONE
                    binding.activeExpandView.visibility = View.GONE
                    schedule.isExpanded.not()
                }
                notifyItemChanged(adapterPosition)
                scheduleCallBack.onClickItemView(schedule.eTakingTime)
            }

            binding.takingScheduleMainCheckBox.setOnClickListener {
                scheduleCallBack.onScheduleCheckButtonClick(schedule.eTakingTime)
            }
        }
    }
}