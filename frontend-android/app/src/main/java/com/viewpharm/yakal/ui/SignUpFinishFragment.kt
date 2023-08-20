package com.viewpharm.yakal.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpFinishBinding

class SignUpFinishFragment : Fragment() {
    private var _binding: FragmentSignUpFinishBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
         _binding = FragmentSignUpFinishBinding.inflate(inflater, container, false)

        activity?.onBackPressedDispatcher?.addCallback(viewLifecycleOwner, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
            }
        })
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setTextView()
        onButtonClickEvent()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun setTextView() {
        val titleText: String = "회원가입이 완료되었습니다"
        binding.titleTextView.text = titleText
    }

    private fun onButtonClickEvent() {
        binding.finishButton.setOnClickListener {
            activity?.finish()
        }
    }
}