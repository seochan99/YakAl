package com.viewpharm.yakal.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpTermBinding

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
            Navigation.createNavigateOnClickListener(R.id.action_signUpTermFragment_to_signUpCertificationFragment).onClick(it)
        }
        super.onViewCreated(view, savedInstanceState)

        binding.serviceAgreeDetailButton.setOnClickListener {
            Navigation.createNavigateOnClickListener(R.id.action_signUpTermFragment_to_signUpTermDetailFragment).onClick(view)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding  = null
    }
}