package com.viewpharm.yakal.main.adapter

import android.annotation.SuppressLint
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemPillParentBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.type.ETakingTime
import timber.log.Timber

class PillParentAdapter(
    private val schedules : List<Schedule>,
    private val scheduleCallBack: MainCallBack.ScheduleCallBack,
    private val todoCallBack: MainCallBack.TodoCallBack,
    private val onOverlapItemCallBack: MainCallBack.OverLapCallback?,)
    : ListAdapter<Schedule, PillParentAdapter.PillParentViewHolder>(ScheduleDiffUtil) {

    companion object {
        object ScheduleDiffUtil : DiffUtil.ItemCallback<Schedule>() {
            override fun areItemsTheSame(oldItem: Schedule, newItem: Schedule): Boolean {
                return oldItem.eTakingTime == newItem.eTakingTime
            }

            override fun areContentsTheSame(oldItem: Schedule, newItem: Schedule): Boolean {
                if (oldItem != newItem) {
                    Timber.d("oldItem : ${oldItem.isExpanded}")
                    Timber.d("newItem : ${newItem.isExpanded}")
                    Timber.d("equal : ${oldItem == newItem}")
                }
                // Schedule 및 PillTodo 를 비교
                return oldItem == newItem
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PillParentViewHolder {
        return PillParentViewHolder(
            ItemPillParentBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: PillParentViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class PillParentViewHolder(val binding : ItemPillParentBinding) :RecyclerView.ViewHolder(binding.root) {
        @SuppressLint("ResourceAsColor")
        fun bind(schedule: Schedule) {
            binding.schedule = schedule
            binding.executePendingBindings()

            if (schedule.eTakingTime == ETakingTime.INVISIBLE) {
                binding.takingScheduleMainCardView.visibility = View.INVISIBLE
                return
            }

            binding.todayTakingScheduleSubRecyclerView.apply {
                layoutManager = LinearLayoutManager(context)
                adapter = PillChildrenAdapter(schedule.isCompleted, schedule.eTakingTime, schedule.todos,
                    todoCallBack, onOverlapItemCallBack)
                setHasFixedSize(true)
            }

            if (schedule.isCompleted) {
                binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#FF2666F6"))
                binding.takingScheduleMainCheckBox.setBackgroundResource(R.drawable.checkbox_big_skyblue)
            } else {
                binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#FFC6C6CF"))
                binding.takingScheduleMainCheckBox.setBackgroundResource(R.drawable.checkbox_big_white)
            }

            if (schedule.isExpanded) {
                binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FF2666F6")
                binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_on)
                binding.todayTakingScheduleSubRecyclerView.visibility = View.VISIBLE
                binding.activeExpandView.visibility = View.VISIBLE
            } else {
                binding.takingScheduleMainCardView.strokeColor = Color.parseColor("#FFE9E9EE")
                binding.takingScheduleMainImageView.setImageResource(R.drawable.ic_custom_list_pill_off)
                binding.todayTakingScheduleSubRecyclerView.visibility = View.GONE
                binding.activeExpandView.visibility = View.GONE
            }

            binding.takingScheduleLayout.setOnClickListener {
                scheduleCallBack.onClickItemView(schedule.eTakingTime)
            }

            binding.takingScheduleMainCheckBox.setOnClickListener() {
                scheduleCallBack.onTodoCheckButtonClick(schedule.eTakingTime)
            }
        }
    }
}