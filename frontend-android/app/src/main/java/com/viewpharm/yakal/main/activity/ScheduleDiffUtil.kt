package com.viewpharm.yakal.main.activity

import androidx.recyclerview.widget.DiffUtil
import com.viewpharm.yakal.main.model.Schedule
import timber.log.Timber

object ScheduleDiffUtil : DiffUtil.ItemCallback<Schedule>() {
    override fun areItemsTheSame(oldItem: Schedule, newItem: Schedule): Boolean {
        return oldItem.eTakingTime == newItem.eTakingTime
    }

    override fun areContentsTheSame(oldItem: Schedule, newItem: Schedule): Boolean {
        // Schedule 및 PillTodo 를 비교
        return oldItem == newItem
    }
}