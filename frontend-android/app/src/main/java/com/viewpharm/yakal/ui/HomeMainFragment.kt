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
import androidx.recyclerview.widget.LinearLayoutManager
import com.viewpharm.yakal.ETakingTime
import com.viewpharm.yakal.Pill
import com.viewpharm.yakal.PillTodo
import com.viewpharm.yakal.PillTodoAdapter
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentHomeBinding
import timber.log.Timber
import java.text.SimpleDateFormat

class HomeMainFragment : Fragment() {
    private lateinit var binding: FragmentHomeBinding
    private var isPillFabsVisible: Boolean? = null
    private var existPill: Boolean = true;
    private var pillTotalCnt : Int = 0;
    private var percent: Int = 0
    private val pillTodos : List<PillTodo> = listOf(
        PillTodo(ETakingTime.MORNING, 3, false, false, listOf(
            Pill("1", false),
            Pill("2", true),
            Pill("3", false)
        )),
        PillTodo(ETakingTime.AFTERNOON, 2, false, false, listOf(
            Pill("1", true),
            Pill("2", true),
        )),
        PillTodo(ETakingTime.EVENING, 3, false, false, listOf(
            Pill("1", true),
            Pill("2", true),
            Pill("3", false)
        )),
    )

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

        binding.todayTakingScheduleMainRecyclerView.apply {
            // 수직으로 출력
            layoutManager = LinearLayoutManager(context)

            // Data 관리
            adapter = PillTodoAdapter(pillTodos)

            // 리사이클러뷰의 크기가 변할 일이 없으므로,
            // 그럼 누구 새로 들어오거나 나갈때 아이템들의 자리만 다시 잡아준다. (리소스 최적화)
            setHasFixedSize(true)
        }

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        isPillFabsVisible = false;

        // MVVM 모델로 만들기(데이터 연결 예정)
        pillTotalCnt = 8;

        // 데이터 들고 오기(HTTP 통신)
        initViews(8)
        setNotificationButtonClickEvent()
        setAnotherTakingLayoutClickEvent()
        setAddPillButtonClickEvent()
        setAddPillGrayLayoutClickEvent()

        super.onViewCreated(view, savedInstanceState)
    }

    private fun initViews(count: Int) {
        // 약 추가 버튼 초기화
        binding.addPillListButton.extend()



        setInitTakingTextView(10)
    }

    private fun setInitTakingTextView(count: Int) {
        if (existPill) {
            val todayFormat = SimpleDateFormat("yyyy년 MM월 dd일")
            binding.todayDateTextView.text = todayFormat.format(System.currentTimeMillis());

            val takingText: String = "오늘 복용해야 하는 약은\n총 ${count}개입니다"
            binding.todayTakingTextView.text = takingText.run {
                val start = this.indexOf("총")
                val end = this.indexOf("개") + 1

                SpannableStringBuilder(this).apply {
                    setSpan(
                        ForegroundColorSpan(Color.parseColor("#2666F6")),
                        start,
                        end,
                        SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                }
            }
            binding.nonePillLayout.visibility = View.GONE

            setTakingEvent(percent)
        } else {
            binding.todayTakingTextView.text = "오늘 복용해야 하는 약은\n없습니다."
            binding.todayPercentBar.visibility = View.GONE
            binding.todayPercentTextView.visibility = View.GONE
            binding.nonePillLayout.visibility = View.VISIBLE
        }
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