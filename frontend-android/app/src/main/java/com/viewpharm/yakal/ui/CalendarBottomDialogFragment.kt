package com.viewpharm.yakal.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.viewpharm.yakal.adapter.CalendarAdapter
import com.viewpharm.yakal.databinding.FragmentCalenderBottomSheetBinding
import com.viewpharm.yakal.model.CalendarTaking
import timber.log.Timber
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.DateTimeFormatter
import kotlin.random.Random


class CalendarBottomDialogFragment : BottomSheetDialogFragment() {
    private lateinit var binding: FragmentCalenderBottomSheetBinding
    private var localDate: LocalDate = LocalDate.now()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Timber.d("CalendarBottomDialogFragment Create")
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCalenderBottomSheetBinding.inflate(inflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setMonthView()
    }

    private fun setMonthView() {
        binding.monthTextView.text = monthYearFromDate(localDate)

        binding.calendarMonthRecyclerView.apply {
            layoutManager = GridLayoutManager(context, 7)
            adapter = CalendarAdapter(daysInMonthArray(localDate))
        }
    }

    private fun monthYearFromDate(date: LocalDate): String? {
        val formatter = DateTimeFormatter.ofPattern("yyyy년 MM월")
        return date.format(formatter)
    }

    fun previousMonthAction(view: View?) {
        localDate = localDate.minusMonths(1)
        setMonthView()
    }

    fun nextMonthAction(view: View?) {
        localDate = localDate.plusMonths(1)
        setMonthView()
    }

    private fun daysInMonthArray(date: LocalDate): List<CalendarTaking> {
        val daysInMonthArray = ArrayList<CalendarTaking>()
        val yearMonth = YearMonth.from(date)
        val daysInMonth = yearMonth.lengthOfMonth()
        val firstOfMonth: LocalDate = localDate.withDayOfMonth(1)
        val dayOfWeek = firstOfMonth.dayOfWeek.value
        val random = Random


        for (i in 1..42) {
            if (i <= dayOfWeek || i > daysInMonth + dayOfWeek) {
                daysInMonthArray.add(CalendarTaking(0, "", false))
            } else {
                daysInMonthArray.add(CalendarTaking(random.nextInt(101), (i - dayOfWeek).toString(), random.nextInt(101) % 2 == 0))
            }
        }
        for (i in 0 until daysInMonthArray.size) {
            Timber.d(daysInMonthArray[i].toString())
        }

        return daysInMonthArray
    }
}