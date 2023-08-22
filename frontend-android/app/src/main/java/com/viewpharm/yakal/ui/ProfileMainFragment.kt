package com.viewpharm.yakal.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.viewpharm.yakal.databinding.FragmentHomeBinding
import com.viewpharm.yakal.databinding.FragmentProfileBinding
import com.viewpharm.yakal.view.MainActivity
import timber.log.Timber

class ProfileMainFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.editNickNameButton.setOnClickListener {
            NicknameEditDialog().also {
                it.show((activity as MainActivity).supportFragmentManager, NicknameEditDialog.TAG)
            }
        }

        binding.selfTestLayer.setOnClickListener {
            Timber.d("selfTestLayer")
        }

        binding.exportTakingLayout.setOnClickListener {
            Timber.d("exportTakingLayout")
        }

        binding.appSettingLayout.setOnClickListener {
            Timber.d("appSettingLayout")
        }

        binding.notificationSettingLayout.setOnClickListener {
            Timber.d("notificationSettingLayout")
        }

        binding.locationSettingLayout.setOnClickListener {
            Timber.d("locationSettingLayout")
        }

        binding.requestLayout.setOnClickListener {
            Timber.d("requestLayout")
        }

        binding.questionLayout.setOnClickListener {
            Timber.d("questionLayout")
        }

        binding.expertLayout.setOnClickListener {
            Timber.d("expertLayout")
        }
    }
}