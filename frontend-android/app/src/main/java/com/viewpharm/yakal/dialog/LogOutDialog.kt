package com.viewpharm.yakal.dialog

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import com.viewpharm.yakal.databinding.DialogLogOutBinding
import com.viewpharm.yakal.main.activity.MainCallBack

class LogOutDialog(
    private val callback: MainCallBack.LogOutCallback): DialogFragment() {
    private var _binding: DialogLogOutBinding? = null
    private val binding get() = _binding!!

    companion object {
        const val TAG = "LogOutDialog"
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = DialogLogOutBinding.inflate(inflater, container, false)
        dialog?.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.cancelButton.setOnClickListener {
            dismiss()
        }
        binding.logoutButton.setOnClickListener {
            callback.onLogOutButtonClick()
            dismiss()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}