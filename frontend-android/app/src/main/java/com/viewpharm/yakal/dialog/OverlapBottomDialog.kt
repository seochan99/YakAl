package com.viewpharm.yakal.dialog

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.main.view.PillAdapter
import com.viewpharm.yakal.databinding.FragmentOverlapBottomSheetBinding
import com.viewpharm.yakal.model.Pill
import timber.log.Timber

class OverlapBottomDialog(
    private val overlapPills : List<Pill>?) : BottomSheetDialogFragment() {

    companion object {
        const val TAG = "OverlapBottomDialog"
    }

    private lateinit var binding: FragmentOverlapBottomSheetBinding
    private var temp = listOf(
        Pill("1", false),
        Pill("2", true),
        Pill("3", false)
    )

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        Timber.d("onCreateDialog")
        return super.onCreateDialog(savedInstanceState)
//        val dialog = BottomSheetDialog(requireContext(), theme)
//        dialog.setOnShowListener {
//            val bottomSheetDialog = it as BottomSheetDialog
//            val parentLayout =
//                bottomSheetDialog.findViewById<View>(com.google.android.material.R.id.design_bottom_sheet)
//            parentLayout?.let { it ->
//                val behaviour = BottomSheetBehavior.from(it)
//                behaviour.state = BottomSheetBehavior.STATE_EXPANDED
//            }
//        }
//
//        Timber.d("onCreateDialog")
//        return dialog
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentOverlapBottomSheetBinding.inflate(inflater)
        Timber.d("onCreateView")
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        Timber.d("onViewCreated")
        _init()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun _init() {
        binding.overlapContentTextView.text = "간단한 설명 주세요..."
        binding.overlapRecyclerView.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = PillAdapter(temp, null)
            setHasFixedSize(true)
        }
    }
}