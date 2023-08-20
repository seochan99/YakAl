package com.viewpharm.yakal.ui

import android.graphics.Typeface
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpTermBinding
import com.viewpharm.yakal.type.ESex
import timber.log.Timber

class SignUpTermFragment() : Fragment() {
    private var _binding: FragmentSignUpTermBinding ?= null
    private val binding get() = _binding!!

    companion object {
        val TAG = "SignUpTermFragment"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding  = FragmentSignUpTermBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.nextButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.action_to_signUpCertificationFragment)
        }
        super.onViewCreated(view, savedInstanceState)

        onCheckButtonClickEvent()
        onDetailButtonClickEvent(view)
        setTextView()
    }

    override fun onResume() {
        super.onResume()
        Timber.d("onResume")
        binding.nextButton.isEnabled = isEssentialAgree()
    }

    private fun setTextView() {
        val titleText: String = "약관을 확인해주세요"
        binding.termTitleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    0,
                    2,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    private fun onCheckButtonClickEvent() {
        binding.totalAgreeCheckBox.setOnClickListener {
            if (binding.totalAgreeCheckBox.isChecked) {
                binding.serviceAgreeCheckBox.isChecked = true
                binding.locationAgreeCheckBox.isChecked = true
                binding.informationAgreeCheckBox.isChecked = true
                binding.marketingAgreeCheckBox.isChecked = true
            } else {
                binding.serviceAgreeCheckBox.isChecked = false
                binding.locationAgreeCheckBox.isChecked = false
                binding.informationAgreeCheckBox.isChecked = false
                binding.marketingAgreeCheckBox.isChecked = false
            }
            binding.nextButton.isEnabled = isEssentialAgree()
        }

        binding.serviceAgreeCheckBox.setOnClickListener {
            binding.totalAgreeCheckBox.isChecked = isAllAgree()
            binding.nextButton.isEnabled = isEssentialAgree()
        }

        binding.locationAgreeCheckBox.setOnClickListener {
            binding.totalAgreeCheckBox.isChecked = isAllAgree()
            binding.nextButton.isEnabled = isEssentialAgree()
        }

        binding.informationAgreeCheckBox.setOnClickListener {
            binding.totalAgreeCheckBox.isChecked = isAllAgree()
            binding.nextButton.isEnabled = isEssentialAgree()
        }

        binding.marketingAgreeCheckBox.setOnClickListener {
            binding.totalAgreeCheckBox.isChecked = isAllAgree()
        }
    }

    private fun onDetailButtonClickEvent(view: View) {
        // 데이터 넘기기 예정
        binding.serviceAgreeDetailButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.action_to_signUpTermDetailFragment)
        }
        binding.locationAgreeDetailButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.action_to_signUpTermDetailFragment)
        }
        binding.informationAgreeDetailButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.action_to_signUpTermDetailFragment)
        }
        binding.marketingAgreeDetailButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.action_to_signUpTermDetailFragment)
        }
    }
    private fun isAllAgree(): Boolean {
        return binding.serviceAgreeCheckBox.isChecked && binding.locationAgreeCheckBox.isChecked && binding.informationAgreeCheckBox.isChecked && binding.marketingAgreeCheckBox.isChecked
    }

    private fun isEssentialAgree(): Boolean {
        return binding.serviceAgreeCheckBox.isChecked && binding.locationAgreeCheckBox.isChecked && binding.informationAgreeCheckBox.isChecked
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding  = null
    }
}