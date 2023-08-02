package com.viewpharm.yakal.ui

import android.graphics.Color
import android.opengl.Visibility
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
import android.text.style.ForegroundColorSpan
import android.text.style.TextAppearanceSpan
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentHomeBinding
import timber.log.Timber
import java.text.SimpleDateFormat

class HomeMainFragment : Fragment() {
    private lateinit var binding: FragmentHomeBinding
    private var isPillFabsVisible : Boolean? = null
    private var percent: Int = 0

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
        isPillFabsVisible = false;

        initViews(10)
        setNotificationButtonClickEvent()
        setAnotherTakingLayoutClickEvent()
        setAddPillButtonClickEvent()
        setAddPillGrayLayoutClickEvent()

        super.onViewCreated(view, savedInstanceState)
    }

    private fun initViews(count: Int) {
        // 약 추가 버튼 초기화
        binding.addDirectPillButton.visibility = View.GONE
        binding.addGeneralPillButton.visibility = View.GONE
        binding.addPrescriptionButton.visibility = View.GONE
        binding.addPillListButton.extend()

        // 글자 초기화
        val todayFormat = SimpleDateFormat("yyyy년 MM월 dd일")
        binding.todayDateTextView.text = todayFormat.format(System.currentTimeMillis());

        val takingText : String = "오늘 복용해야 하는 약은\n총 ${count}개입니다"
        binding.todayTakingTextView.text = takingText.run {
            val start = this.indexOf("총")
            val end = this.indexOf("개") + 1

            SpannableStringBuilder(this).apply {
                setSpan(ForegroundColorSpan(Color.parseColor("#2666F6")),
                    start,
                    end,
                    SPAN_EXCLUSIVE_EXCLUSIVE )
            }
        }

        // 프로그래스바 초기화
        setTakingEvent(percent)
    }

    // 약 먹을 때 이벤트(Text 및 Progress)
    private fun setTakingEvent(percent: Int) {
        binding.todayPercentBar.progress = percent

        if (percent == 0) {
            binding.todayPercentTextView.setTextColor(Color.parseColor("#FFC1D2FF"))
        } else {
            binding.todayPercentTextView.setTextColor(Color.parseColor("#FF5588FD"))
        }

        binding.todayPercentTextView.text = "${percent}%"
    }

    // 알람 버튼 이벤트
    private fun setNotificationButtonClickEvent() {
        binding.goNotificationButton.setOnClickListener {
            Timber.d("알람 버튼 클릭")
            percent += 10
            setTakingEvent(percent)
        }
    }

    // 다른 날짜 복약정보 버튼 이벤트
    private fun setAnotherTakingLayoutClickEvent() {
        binding.anotherTakingLayout.setOnClickListener {
            Timber.d("다른 날짜 복약정보 버튼 클릭")
            percent -= 10
            setTakingEvent(percent)
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