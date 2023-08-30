package com.viewpharm.yakal.dialog

import android.annotation.SuppressLint
import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.adapter.CalendarAdapter
import com.viewpharm.yakal.databinding.FragmentCalenderBottomSheetBinding
import com.viewpharm.yakal.util.CalendarUtil
import timber.log.Timber
import java.time.LocalDate


class CalendarBottomDialog(private var currentDate : LocalDate) : BottomSheetDialogFragment() {
    private lateinit var binding: FragmentCalenderBottomSheetBinding

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = BottomSheetDialog(requireContext(), theme)
        dialog.setOnShowListener {

            val bottomSheetDialog = it as BottomSheetDialog
            val parentLayout =
                bottomSheetDialog.findViewById<View>(com.google.android.material.R.id.design_bottom_sheet)
            parentLayout?.let { it ->
                val behaviour = BottomSheetBehavior.from(it)
                behaviour.state = BottomSheetBehavior.STATE_EXPANDED
            }
        }

        Timber.d("onCreateDialog")
        return dialog
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCalenderBottomSheetBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _init()
    }

    private fun _init() {
        setDateTextView()
        setPreviousButton()
        setNextButton()

        binding.calendarMonthRecyclerView.apply {
            layoutManager = GridLayoutManager(context, 7)
            adapter = CalendarAdapter(currentDate, CalendarUtil.daysInMonthArray(currentDate))
            setHasFixedSize(true)
        }
    }

    @SuppressLint("NotifyDataSetChanged")
    private fun setDateView() {
        setDateTextView()

        binding.calendarMonthRecyclerView.adapter?.let {
            (it as CalendarAdapter).setCalendarTakingList(currentDate, CalendarUtil.daysInMonthArray(currentDate))
            it.notifyItemRangeChanged(0, 42)
        }
    }

    private fun setDateTextView() {
        binding.monthTextView.text = CalendarUtil.getFormattedMonthFromDate(currentDate)
    }

    private fun setPreviousButton() {
        binding.previousButton.setOnClickListener {
            currentDate = currentDate.minusMonths(1)
            setDateView();
        }
    }

    private fun setNextButton() {
        binding.nextButton.setOnClickListener {
            currentDate = currentDate.plusMonths(1)
            setDateView();
        }
    }
}