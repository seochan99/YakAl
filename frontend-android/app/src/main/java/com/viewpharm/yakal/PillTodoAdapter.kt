package com.viewpharm.yakal

import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.util.SparseBooleanArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.AlphaAnimation
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.viewpharm.yakal.databinding.ItemHomePillMainBinding
import timber.log.Timber

class PillTodoAdapter(private val pillTodos: List<PillTodo>) : RecyclerView.Adapter<PillTodoAdapter.PillTodoViewHolder>() {
    private val selectedItems : SparseBooleanArray = SparseBooleanArray();
    private var prePosition : Int = -1;


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PillTodoViewHolder {
        Timber.d("onCreateViewHolder")
        return PillTodoViewHolder(
            ItemHomePillMainBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false // 리사이클 뷰랑 연결 시키는 것으로 리사이클 뷰가 알아서 해야 한다.(true할 시 오류)
            )
        )
    }

    override fun onBindViewHolder(holder: PillTodoViewHolder, position: Int) {
        Timber.d("onBindViewHolder")
        holder.bind(pillTodos[position])
    }

    override fun getItemCount(): Int = pillTodos.size

    inner class PillTodoViewHolder(private val binding : ItemHomePillMainBinding) :RecyclerView.ViewHolder(binding.root) {
        fun bind(pillTodo: PillTodo) {
            binding.todayTakingScheduleSubRecyclerView.apply {
                layoutManager = LinearLayoutManager(context)
                adapter = PillAdapter(pillTodo.pills)
                setHasFixedSize(true)
            }

            binding.takingScheduleMainTimeView.text = pillTodo.ETime.toString()
            binding.takingScheduleMainCountView.text = "${pillTodo.totalCnt.toString()}개"
            if (pillTodo.completed) {
                binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#2666F6"))
            }
            binding.takingScheduleMainCheckBox.isChecked = pillTodo.completed

            itemView.setOnClickListener {
                Timber.d("Item Click 이벤트 발생")
                pillTodo.isExpanded = if (!pillTodo.isExpanded) {
                    binding.takingScheduleMainItem.setBackgroundResource(R.drawable.it_home_pill_main_expand)
                    binding.activeExpandView.visibility = View.VISIBLE
                    binding.inactiveExpandView.visibility = View.INVISIBLE

                    binding.todayTakingScheduleSubRecyclerView.visibility = View.VISIBLE
                    binding.todayTakingScheduleSubRecyclerView.animate().apply {
                        duration = 200
                        rotation(0f)
                    }

                    pillTodo.isExpanded.not()
                }else {
                    binding.takingScheduleMainItem.setBackgroundResource(R.drawable.it_home_pill_main_shrink)
                    binding.activeExpandView.visibility = View.INVISIBLE
                    binding.inactiveExpandView.visibility = View.VISIBLE

                    binding.todayTakingScheduleSubRecyclerView.visibility = View.GONE
                    binding.todayTakingScheduleSubRecyclerView.animate().apply {
                        duration = 200
                        rotation(0f)
                    }

                    pillTodo.isExpanded.not()
                }
            }


            binding.takingScheduleMainCheckBox.setOnClickListener {
                pillTodo.completed = if (pillTodo.completed) {
                    binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#C6C6CF"))
                    pillTodo.completed.not()
                } else {
                    binding.takingScheduleMainCompeletedTextView.setTextColor(Color.parseColor("#2666F6"))
                    pillTodo.completed.not()
                }
            }
        }
    }
}