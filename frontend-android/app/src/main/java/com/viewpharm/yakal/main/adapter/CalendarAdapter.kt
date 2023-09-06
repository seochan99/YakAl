package com.viewpharm.yakal.main.adapter

import android.annotation.SuppressLint
import android.graphics.Color
import android.graphics.Typeface
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemCalendarBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.model.DayState
import com.viewpharm.yakal.model.CalendarTaking
import java.time.format.DateTimeFormatter

class CalendarAdapter(private val dayStates : List<DayState>,
    private val callback: MainCallBack.CalendarCallback)
    : ListAdapter<DayState, CalendarAdapter.CalendarViewHolder>(DayDiffUtil) {

    companion object {
        object DayDiffUtil : androidx.recyclerview.widget.DiffUtil.ItemCallback<DayState>() {
            override fun areItemsTheSame(oldItem: DayState, newItem: DayState): Boolean {
                return oldItem.date == newItem.date && oldItem.isVisible == newItem.isVisible
            }

            override fun areContentsTheSame(oldItem: DayState, newItem: DayState): Boolean {
                return oldItem == newItem
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CalendarViewHolder {
        return CalendarViewHolder(
            ItemCalendarBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CalendarAdapter.CalendarViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class CalendarViewHolder(private val binding: ItemCalendarBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(dayState: DayState) {
            binding.state = dayState
            binding.executePendingBindings()

            if (!dayState.isVisible) {
                binding.calendarItemLayout.visibility = View.INVISIBLE
            } else {
                binding.calendarItemLayout.visibility = View.VISIBLE
            }

            if (dayState.percent == 100) {
                binding.todayPercentBar.setBackgroundResource(
                    R.drawable.view_oval_full
                )
            } else {
                binding.todayPercentBar.setBackgroundResource(
                    R.drawable.view_oval
                )
            }

            if (dayState.isSelected) {
                binding.calendarDayTextView.apply {
                    setTextColor(Color.parseColor("#FFFFFF"))
                }
            } else {
                binding.calendarDayTextView.apply {
                    setTextColor(Color.parseColor("#000000"))
                }
            }

            itemView.setOnClickListener {
                callback.onCalendarButtonClick(dayState.date)
            }
        }
    }
}