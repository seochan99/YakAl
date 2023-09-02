package com.viewpharm.yakal.main.view

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.databinding.ItemHomePillSubBinding
import com.viewpharm.yakal.dialog.OverlapBottomDialog
import com.viewpharm.yakal.main.viewmodel.HomeTodoViewModel
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.main.model.Schedule
import com.viewpharm.yakal.view.PillDetailActivity
import timber.log.Timber

class PillAdapter(private val viewModel: HomeTodoViewModel) : RecyclerView.Adapter<PillAdapter.PillViewHolder>() {
    private val pillTodos:List<PillTodo> = (viewModel.schedules.value!! as Schedule).pills

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
        holder.bind(pillTodos[position])
    }

    override fun getItemCount(): Int = pills.size

    inner class PillViewHolder(private val binding: ItemHomePillSubBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(todo: PillTodo) {
            binding.takingScheduleSubFillNameTextView.text = pill.name
            binding.takingScheduleSubCheckBox.isChecked = pill.completed

            itemView.setOnClickListener {
                Timber.d("Test 중")
                val intent = Intent(binding.root.context, PillDetailActivity::class.java)
                intent.run { binding.root.context.startActivity(this) }
            }

            binding.takingScheduleSubCheckBox.setOnClickListener {
                pill.completed = !pill.completed
                binding.takingScheduleSubCheckBox.isChecked = pill.completed
            }

            binding.overLapImageBottom.setOnClickListener {
                OverlapBottomDialog(pills).also {
                    onOverlapItemCallBack?.onOverlapItemClick(pills)
                }
            }
        }
    }

    interface OnOverlapItemCallBack {
        fun onOverlapItemClick(pills : List<Pill>)
    }
}