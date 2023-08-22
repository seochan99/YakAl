package com.viewpharm.yakal.signup.fragment

import android.graphics.Typeface
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.viewpharm.yakal.databinding.FragmentSignUpCertificationBinding
import com.viewpharm.yakal.type.ESex


class SignUpCertificationFragment : Fragment() {
    private var _binding: FragmentSignUpCertificationBinding?= null
    private val binding get() = _binding!!
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentSignUpCertificationBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setTextView()
        onButtonClickEvent(view)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun setTextView() {
        val titleText: String = "본인인증을 해주세요"
        binding.titleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    0,
                    4,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    private fun onButtonClickEvent(view: View) {
        binding.certificationButton.setOnClickListener {
            // 인증 완료 후 뒤로 온 상태 예외 처리 해야함
            Toast.makeText(context, "준비 중 입니다.", Toast.LENGTH_SHORT).show()
        }

        binding.skipButton.setOnClickListener {
            val birthDay = "0000-00-00"
            val sex = ESex.FEMALE

            Navigation.findNavController(view)
                .navigate(
                    SignUpCertificationFragmentDirections.actionToSignUpNicknameFragment(
                        birthDay,
                        sex
                    )
                )
        }
    }
}