package com.viewpharm.yakal.ui

import android.app.Dialog
import android.os.Bundle
import android.text.Editable
import android.text.InputFilter
import android.text.TextWatcher
import android.text.style.TtsSpan.TimeBuilder
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.adapter.PillAdapter
import com.viewpharm.yakal.databinding.FragmentNicknameEditBottomSheetBinding
import com.viewpharm.yakal.databinding.FragmentOverlapBottomSheetBinding
import com.viewpharm.yakal.model.Pill
import com.viewpharm.yakal.view.MainActivity
import timber.log.Timber
import java.sql.Time
import java.util.regex.Pattern

class NicknameEditDialog() : BottomSheetDialogFragment() {
    companion object {
        const val TAG = "NicknameEditDialog"
    }

    private var _binding: FragmentNicknameEditBottomSheetBinding? = null
    private val binding get() = _binding!!

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return super.onCreateDialog(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentNicknameEditBottomSheetBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        Timber.d("onViewCreated")
        onButtonClickEvent(view)
        setEditText()

        binding.nicknameCloseButton.setOnClickListener {
            dismiss()
        }
        super.onViewCreated(view, savedInstanceState)
    }

    override fun onDestroy() {
        super.onDestroy()
        _binding = null
    }

    private fun onButtonClickEvent(view: View) {
        binding.nextButton.setOnClickListener {
            val pattern: Pattern = Pattern.compile("^[가-힣]+$")
            if (pattern.matcher(binding.nicknameEditText.text.toString()).matches()) {
                (activity as MainActivity).displayToast("${binding.nicknameEditText.text}으로 변경되었습니다")
                dismiss()
            } else {
                Toast.makeText(context, "초성, 중성 입력이 존재합니다.", Toast.LENGTH_SHORT).show()
            }
        }

        binding.textClearButton.setOnClickListener {
            binding.nicknameEditText.setText("")
        }
    }

    private fun setEditText() {
        val filterSpace = InputFilter { source, start, end, dest, dstart, dend ->
            val ps: Pattern = Pattern.compile("^[ㄱ-ㅣ가-힣]+$")
            if (ps.matcher(source).matches() || source == "" || source.isEmpty()) {
                source
            } else {
                Toast.makeText(context, "한글만 입력 가능합니다.", Toast.LENGTH_SHORT).show()
                ""
            }
        }
        binding.nicknameEditText.filters = arrayOf(filterSpace, InputFilter.LengthFilter(5))
        binding.nicknameEditText.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
                binding.nextButton.isEnabled = binding.nicknameEditText.text.toString().isNotEmpty()
                binding.textClearButton.visibility = if (binding.nicknameEditText.text.toString().isNotEmpty()){
                    View.VISIBLE
                } else{
                    View.INVISIBLE
                }
            }
            override fun afterTextChanged(s: Editable) {}
        })
    }
}