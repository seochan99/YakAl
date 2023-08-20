package com.viewpharm.yakal.ui

import android.graphics.Typeface
import android.os.Bundle
import android.text.Editable
import android.text.InputFilter
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.TextWatcher
import android.text.style.StyleSpan
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpNicknameBinding
import com.viewpharm.yakal.type.ESex
import java.util.regex.Pattern


class SignUpNicknameFragment : Fragment() {
    private var _binding: FragmentSignUpNicknameBinding?= null
    private val binding get() = _binding!!
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding =  FragmentSignUpNicknameBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setTextView()
        setEditText()
        onButtonClickEvent(view)
    }

    private fun setTextView() {
        val titleText: String = "약알에서 사용할\n닉네임을 입력해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    9,
                    12,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    private fun onButtonClickEvent(view: View) {
        binding.nextButton.setOnClickListener {
            val pattern: Pattern = Pattern.compile("^[가-힣]+$")
            if (pattern.matcher(binding.nicknameEditText.text.toString()).matches()) {
                val safeArgs: SignUpNicknameFragmentArgs by navArgs()

                Navigation.findNavController(view)
                    .navigate(SignUpNicknameFragmentDirections
                        .actionToSignUpModeFragment(safeArgs.birthday, safeArgs.sex, binding.nicknameEditText.text.toString()))
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
            if (ps.matcher(source).matches() || source == "") {
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