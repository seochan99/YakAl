package com.viewpharm.yakal.dialog

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.databinding.FragmentOverlapBottomSheetBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.adapter.PillChildrenAdapter
import com.viewpharm.yakal.main.model.PillTodo
import com.viewpharm.yakal.type.ETakingTime
import timber.log.Timber

class OverlapBottomDialog(
    private val overlapPills : List<PillTodo>) : BottomSheetDialogFragment() {

    companion object {
        const val TAG = "OverlapBottomDialog"
    }

    private var _binding: FragmentOverlapBottomSheetBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentOverlapBottomSheetBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView()
    }

    override fun onDestroyView() {
        _binding = null
        super.onDestroyView()
    }

    private fun initView() {
        binding.overlapRecyclerView.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = PillChildrenAdapter(isCompleted = false,
                eTakingTime = ETakingTime.INVISIBLE,
                todos = overlapPills,
                todoCallBack = null,
                onOverlapItemCallBack = null)
            setHasFixedSize(true)
        }

        binding.overlapCloseButton.setOnClickListener {
            dismiss()
        }
    }
}