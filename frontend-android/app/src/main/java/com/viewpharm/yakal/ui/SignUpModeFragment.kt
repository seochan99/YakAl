package com.viewpharm.yakal.ui

import android.graphics.Color
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.AbsoluteSizeSpan
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpModeBinding

class SignUpModeFragment : Fragment() {
    private var _binding: FragmentSignUpModeBinding?= null
    private val binding get() = _binding!!
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSignUpModeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        onButtonClickEvent(view)
        setTextView()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun setTextView() {
        val titleText: String = "모드를 선택해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(android.graphics.Typeface.BOLD),
                    0,
                    2,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

        val normalModeText: String = "일반 모드\n\n약알의 일반적인 모드입니다"
        binding.normalModeRadioButton.text = normalModeText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    AbsoluteSizeSpan(24, true),
                    0,
                    6,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }

        val lightModeText: String = "라이트 모드\n\n시니어를 위한 쉬운 모드입니다.\n다제약물 정보가 포함되어 있습니다."
        binding.lightModeRadioButton.text = lightModeText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    AbsoluteSizeSpan(24, true),
                    0,
                    7,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
                setSpan(
                    StyleSpan(android.graphics.Typeface.BOLD),
                    8,
                    21,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    private fun onButtonClickEvent(view: View) {
        binding.modeRadioGroup.setOnCheckedChangeListener { _, checkedId ->
            when(checkedId) {
                R.id.normalModeRadioButton -> {
                    binding.nextButton.isEnabled = true
                }
                R.id.lightModeRadioButton -> {
                    binding.nextButton.isEnabled = true
                }
            }

            binding.nextButton.isEnabled = true
        }

        binding.nextButton.setOnClickListener {
            val safeArgs: SignUpModeFragmentArgs by navArgs()

            Navigation.findNavController(view)
                .navigate(SignUpModeFragmentDirections
                    .actionToSignUpFinishFragment(
                        safeArgs.birthday,
                        safeArgs.sex,
                        safeArgs.nickName,
                        binding.lightModeRadioButton.isChecked))
        }
    }
}