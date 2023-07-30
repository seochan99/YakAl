package com.viewpharm.yakal.ui

import android.opengl.Visibility
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentHomeBinding
import timber.log.Timber

class HomeMainFragment : Fragment() {
    private lateinit var binding: FragmentHomeBinding
    private var isPillFabsVisible : Boolean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        // Timber Start Setting
        Timber.plant(Timber.DebugTree())
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater)

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.addDirectPillButton.visibility = View.GONE
        binding.addGeneralPillButton.visibility = View.GONE
        binding.addPrescriptionButton.visibility = View.GONE
        binding.addPillListButton.extend()

        isPillFabsVisible = false;

        setNotificationButtonClickEvent()
        setAnotherTakingLayoutClickEvent()
        setAddPillButtonClickEvent()
        setAddPillGrayLayoutClickEvent()

        super.onViewCreated(view, savedInstanceState)
    }

    // 알람 버튼 이벤트
    private fun setNotificationButtonClickEvent() {
        binding.goNotificationButton.setOnClickListener {
            Timber.d("알람 버튼 클릭")
        }
    }

    // 다른 날짜 복약정보 버튼 이벤트
    private fun setAnotherTakingLayoutClickEvent() {
        binding.anotherTakingLayout.setOnClickListener {
            Timber.d("다른 날짜 복약정보 버튼 클릭")
        }
    }

    // 약 추가 버튼 이벤트
    private fun setAddPillButtonClickEvent() {
        binding.addPillListButton.setOnClickListener {
            isPillFabsVisible = if (!isPillFabsVisible!!) {
                // 회색 처리
                binding.addPillGrayLayout.visibility = View.VISIBLE

                // 약 추가 버튼 보이게 설정
                binding.addDirectPillButton.show()
                binding.addGeneralPillButton.show()
                binding.addPrescriptionButton.show()

                // 추가 메인 버튼 축소 시키기 및 아이콘 바꾸기
                binding.addPillListButton.shrink().apply {
                    binding.addPillListButton.setIconResource(R.drawable.ic_custom_cancel)
                }

                // 전체 메뉴가 보이는 상태이므로 true 넣기
                true
            } else {
                // 약 추가 버튼 안 보이게 설정
                binding.addDirectPillButton.hide()
                binding.addGeneralPillButton.hide()
                binding.addPrescriptionButton.hide()

                // 추가 메인 버튼 확대 시키기 및 아이콘 바꾸기
                binding.addPillListButton.extend().apply {
                    binding.addPillListButton.setIconResource(R.drawable.ic_custom_pill)
                }

                // 회색 처리 해제
                binding.addPillGrayLayout.visibility = View.GONE

                // 전체 메뉴가 안 보이는 상태이므로 false 넣기
                false
            }
        }
    }

    private fun setAddPillGrayLayoutClickEvent() {
        binding.addPillGrayLayout.setOnClickListener {
            // 약 추가 버튼 안 보이게 설정
            binding.addDirectPillButton.hide()
            binding.addGeneralPillButton.hide()
            binding.addPrescriptionButton.hide()

            // 추가 메인 버튼 확대 시키기 및 아이콘 바꾸기
            binding.addPillListButton.extend()
            binding.addPillListButton.setIconResource(R.drawable.ic_custom_pill)

            // 회색 처리 해제
            binding.addPillGrayLayout.visibility = View.GONE

            // 전체 메뉴가 안 보이는 상태이므로 false 넣기
            isPillFabsVisible = false
        }
    }
}