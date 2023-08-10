package com.viewpharm.yakal.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.model.Pill
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemHomePillSubBinding
import timber.log.Timber

class PillAdapter(private val pills : List<Pill>) : RecyclerView.Adapter<PillAdapter.PillViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PillViewHolder {
        Timber.d("onCreateViewHolder")
        return PillViewHolder(
            ItemHomePillSubBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: PillViewHolder, position: Int) {
        Timber.d("onBindViewHolder")
        holder.bind(pills[position])
    }

    override fun getItemCount(): Int = pills.size

    inner class PillViewHolder(private val binding: ItemHomePillSubBinding) : RecyclerView.ViewHolder(binding.root) {
        public fun bind(pill: Pill) {
            if (pill == pills.last()) {
                binding.takingScheduleSubItem.setBackgroundResource(R.drawable.it_home_pill_sub_last)
                binding.inactiveExpandView.visibility = View.VISIBLE
            }
            binding.takingScheduleSubFillNameTextView.text = pill.name
            binding.takingScheduleSubCheckBox.isChecked = pill.completed
        }
    }
}