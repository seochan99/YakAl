package com.viewpharm.yakal.main.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.viewpharm.yakal.databinding.FragmentMainProfileBinding
import com.viewpharm.yakal.dialog.NicknameEditBottomDialog
import com.viewpharm.yakal.main.activity.MainActivity
import com.viewpharm.yakal.signup.fragment.SignUpModeFragmentDirections
import com.viewpharm.yakal.type.EMode
import timber.log.Timber

class MainProfileFragment : Fragment() {
    private lateinit var binding: FragmentMainProfileBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentMainProfileBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.editNickNameButton.setOnClickListener {
            NicknameEditBottomDialog().also {
                it.show((activity as MainActivity).supportFragmentManager, NicknameEditBottomDialog.TAG)
            }
        }

        binding.selfTestLayer.setOnClickListener {
            Timber.d("selfTestLayer")
        }

        binding.exportTakingLayout.setOnClickListener {
            Timber.d("exportTakingLayout")
        }

        binding.appSettingLayout.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(MainProfileFragmentDirections.actionProfileMainFragmentToProfileAppSettingFragment())
        }

        binding.notificationSettingLayout.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(MainProfileFragmentDirections.actionProfileMainFragmentToNotificationSettingFragment())
        }

//        binding.locationSettingLayout.setOnClickListener {
//            Timber.d("locationSettingLayout")
//        }

        binding.requestLayout.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(MainProfileFragmentDirections.actionProfileMainFragmentToRequestFragment())
        }

//        binding.questionLayout.setOnClickListener {
//            Timber.d("questionLayout")
//        }

        binding.expertLayout.setOnClickListener {
            Timber.d("expertLayout")
        }

        (activity as MainActivity).onLogBackStack()
    }
}