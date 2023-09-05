package com.viewpharm.yakal.main.fragment

import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentNotificationSettingBinding
import com.viewpharm.yakal.main.viewmodel.NotificationSettingViewModel

class NotificationSettingFragment :
    BaseFragment<FragmentNotificationSettingBinding, NotificationSettingViewModel>(R.layout.fragment_notification_setting) {

    override val viewModel: NotificationSettingViewModel by lazy {
        NotificationSettingViewModel.NotificationSettingViewModelFactory().create(NotificationSettingViewModel::class.java)
    }

    override fun initView() {
        super.initView()
        binding.takingSwitch.setTrackResource(R.drawable.switch_track)
        binding.takingSwitch.setThumbResource(R.drawable.switch_thumb)
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

}