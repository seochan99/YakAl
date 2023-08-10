package com.viewpharm.yakal.adapter

import android.graphics.Color
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemCalendarDayBinding
import com.viewpharm.yakal.model.CalendarTaking

class CalendarAdapter(private val calendarTakingList : List<CalendarTaking>) : RecyclerView.Adapter<CalendarAdapter.CalendarViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CalendarAdapter.CalendarViewHolder {
        return CalendarViewHolder(
            ItemCalendarDayBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CalendarAdapter.CalendarViewHolder, position: Int) {
        holder.bind(calendarTakingList[position])
    }

    override fun getItemCount(): Int = calendarTakingList.size

    inner class CalendarViewHolder(private val binding: ItemCalendarDayBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(calendarTaking: CalendarTaking) {
            if (calendarTaking.dateOfDay == "") {
                binding.overLapImageView.visibility = ViewGroup.INVISIBLE
                binding.todayPercentBar.visibility = ViewGroup.INVISIBLE
                binding.calendarDayTextView.visibility = ViewGroup.INVISIBLE
                return
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

                if (this == 0) {
                    binding.calendarDayTextView.setTextColor(Color.parseColor("#FFC1D2FF"))
                } else {
                    binding.calendarDayTextView.setTextColor(Color.parseColor("#FF5588FD"))
                }

                binding.calendarDayTextView.text = calendarTaking.dateOfDay
            }
        }
    }
}