package com.viewpharm.yakal.main.adapter

import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.ItemPillChildenBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.type.ETakingTime
import com.viewpharm.yakal.view.PillDetailActivity

class PillChildrenAdapter(
    private val isCompleted: Boolean,
    private val eTakingTime: ETakingTime,
    private val todos :List<PillTodo>,
    private val todoCallBack: MainCallBack.TodoCallBack?,
    private val onOverlapItemCallBack: MainCallBack.OverLapCallback?
    )
    : ListAdapter<PillTodo, PillChildrenAdapter.PillChildrenViewHolder>(DiffUtil) {

    object DiffUtil: androidx.recyclerview.widget.DiffUtil.ItemCallback<PillTodo>() {
        override fun areItemsTheSame(oldItem: PillTodo, newItem: PillTodo): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(oldItem: PillTodo, newItem: PillTodo): Boolean {
            return oldItem == newItem
        }
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PillChildrenViewHolder {
        return PillChildrenViewHolder(ItemPillChildenBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: PillChildrenViewHolder, position: Int) {
        holder.bind(eTakingTime, todos[position])
    }

    override fun getItemCount(): Int = todos.size

    inner class PillChildrenViewHolder(val binding: ItemPillChildenBinding) : RecyclerView.ViewHolder(binding.root) {

        fun bind(eTakingTime: ETakingTime, todo: PillTodo) {
            binding.todo = todo
            binding.executePendingBindings()

            if (onOverlapItemCallBack == null || todoCallBack == null) {
                binding.overLapImageBottom.visibility = View.GONE
                binding.takingScheduleSubCheckBox.visibility = View.GONE
                binding.riskColorView.visibility = View.GONE
                return
            }

            if (isCompleted) {
                binding.takingScheduleSubCheckBox.setBackgroundResource(R.drawable.checkbox_small_skyblue)
            }else {
                binding.takingScheduleSubCheckBox.setBackgroundResource(R.drawable.checkbox_small_white)
            }

            itemView.setOnClickListener {
                val intent = Intent(binding.root.context, PillDetailActivity::class.java)
                intent.run { binding.root.context.startActivity(this) }
            }

            binding.takingScheduleSubCheckBox.setOnClickListener {
                todoCallBack.onTodoCheckButtonClick(eTakingTime, todo.id)
            }

            binding.overLapImageBottom.setOnClickListener {
                onOverlapItemCallBack.onOverLapCheckButtonClick(eTakingTime, todo.atcCode.code)
            }
        }
    }
}