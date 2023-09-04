package com.viewpharm.yakal.dialog

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.databinding.DialogTimeSettingBinding
import com.viewpharm.yakal.main.activity.MainCallBack
import com.viewpharm.yakal.main.model.TakingTime
import com.viewpharm.yakal.type.ETakingTime
import nl.joery.timerangepicker.TimeRangePicker
import timber.log.Timber

class TimeSettingDialog(private val eTakingTime: ETakingTime,
                        private val takingTime: TakingTime,
                        private val callback: MainCallBack.TimeSettingCallback): BottomSheetDialogFragment() {

    companion object {
        const val TAG = "TimeSettingDialog"
    }
    private var _binding: DialogTimeSettingBinding? = null;
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = DialogTimeSettingBinding.inflate(inflater, container, false).also {
            it.lifecycleOwner = this
        }

        binding.takingTime = takingTime
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.titleTextView.text = "$eTakingTime 시간 설정"
        binding.timeRangePicker.startTimeMinutes = takingTime.startTime.hour * 60 + takingTime.startTime.minute
        binding.timeRangePicker.endTimeMinutes = takingTime.endTime.hour * 60 + takingTime.endTime.minute

        binding.timeRangePicker.setOnTimeChangeListener(object : TimeRangePicker.OnTimeChangeListener {
            override fun onStartTimeChange(startTime: TimeRangePicker.Time) {
                binding.startTimeTextView.text = startTime.localTime.toString()
            }

            override fun onEndTimeChange(endTime: TimeRangePicker.Time) {
                binding.endTimeTextView.text = endTime.localTime.toString()
            }

            override fun onDurationChange(duration: TimeRangePicker.TimeDuration) {
            }
        })

        binding.cancelButton.setOnClickListener {
            dismiss()
        }

        binding.completeButton.setOnClickListener {
            val startTime = binding.timeRangePicker.startTime
            val endTime = binding.timeRangePicker.endTime
            if (startTime == null || endTime == null) {
                Timber.e("startTime or endTime is null")
                return@setOnClickListener
            }

            callback.onTimeSettingButtonClick(TakingTime(startTime.localTime, endTime.localTime))
            dismiss()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}