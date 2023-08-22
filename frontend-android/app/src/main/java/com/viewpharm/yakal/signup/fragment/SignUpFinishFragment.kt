package com.viewpharm.yakal.signup.fragment

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.databinding.FragmentSignUpFinishBinding
import com.viewpharm.yakal.signup.activity.SignUpActivity
import timber.log.Timber

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
        val safeArgs: SignUpFinishFragmentArgs by navArgs()

        Timber.e("""
            safeArgs.birthday: ${safeArgs.birthday}
            safeArgs.sex: ${safeArgs.sex}
            safeArgs.nickName: ${safeArgs.nickName}
            safeArgs.isDetail: ${safeArgs.isDetail}
        """)

        binding.finishButton.setOnClickListener {
            (activity as SignUpActivity).navigateToActivity()
        }
    }
}