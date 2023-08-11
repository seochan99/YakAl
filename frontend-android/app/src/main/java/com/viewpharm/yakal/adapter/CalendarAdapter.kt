package com.viewpharm.yakal.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemCalendarBinding
import com.viewpharm.yakal.model.CalendarTaking

class CalendarAdapter(private var calendarTakingList : List<CalendarTaking>) : RecyclerView.Adapter<CalendarAdapter.CalendarViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CalendarAdapter.CalendarViewHolder {
        return CalendarViewHolder(
            ItemCalendarBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CalendarAdapter.CalendarViewHolder, position: Int) {
        holder.bind(calendarTakingList[position])
    }

    override fun onBindViewHolder(
        holder: CalendarViewHolder,
        position: Int,
        payloads: MutableList<Any>
    ) {
        super.onBindViewHolder(holder, position, payloads)
    }

    override fun getItemCount(): Int = calendarTakingList.size

    fun setCalendarTakingList(calendarTakingList: List<CalendarTaking>) {
        this.calendarTakingList = calendarTakingList
    }

    inner class CalendarViewHolder(private val binding: ItemCalendarBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(calendarTaking: CalendarTaking) {
            if (calendarTaking.dateOfDay.isEmpty()) {
                binding.overLapImageView.visibility = ViewGroup.INVISIBLE
                binding.calendarDayTextView.visibility = ViewGroup.INVISIBLE
                binding.todayPercentBar.visibility = ViewGroup.INVISIBLE
                binding.calendarDayTextView.visibility = ViewGroup.INVISIBLE
                return
            } else {
                binding.calendarDayTextView.visibility = ViewGroup.VISIBLE
                binding.overLapImageView.visibility = ViewGroup.VISIBLE
                binding.todayPercentBar.visibility = ViewGroup.VISIBLE
            }

            binding.overLapImageView.visibility = if (calendarTaking.isOverlap) {
                ViewGroup.VISIBLE
            } else {
                ViewGroup.INVISIBLE
            }
            with(calendarTaking.percent) {
                binding.todayPercentBar.progress = this

                if (this == 100) {
                    binding.todayPercentBar.setBackgroundResource(
                        R.drawable.view_oval_temp
                    )
                }

                binding.calendarDayTextView.text = calendarTaking.dateOfDay
            }
        }
    }
}