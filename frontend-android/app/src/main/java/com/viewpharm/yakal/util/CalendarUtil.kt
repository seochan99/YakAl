package com.viewpharm.yakal.util

import com.viewpharm.yakal.main.model.DayState
import com.viewpharm.yakal.model.CalendarTaking
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.DateTimeFormatter
import java.time.temporal.TemporalAdjusters
import kotlin.random.Random


class CalendarUtil {
    companion object {
        fun getFormattedDayFromDate(date: LocalDate): String {
            return date.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"))
        }

        fun getFormattedMonthFromDate(date: LocalDate): String {
            return date.format(DateTimeFormatter.ofPattern("yyyy년 MM월"))
        }

        @Deprecated("Use getFormattedDayFromDate instead")
        // 입력받은 날짜에 대하여 해당 달의 날짜 리스트를 반환, 이때 해당 날짜의 정보를 담은 DayState를 반환
        // 또한, 이전 달의 날짜와 다음 달의 날짜를 포함하여 42개의 날짜를 반환(null 값 없이)
        fun daysInMonthArray(date: LocalDate): List<DayState> {
            val daysInMonthArray = mutableListOf<DayState>()
            val yearMonth = YearMonth.from(date)
            val firstDayOfMonth = date.withDayOfMonth(1)
            val lastDayOfMonth = date.withDayOfMonth(yearMonth.lengthOfMonth())

            val previousMonth = date.minusMonths(1)
            val nextMonth = date.plusMonths(1)

            // 이전 달의 날짜 추가
            val previousMonthLength = YearMonth.of(previousMonth.year, previousMonth.month).lengthOfMonth()
            val previousMonthStartDay = previousMonthLength - firstDayOfMonth.dayOfWeek.value + 2
            for (i in previousMonthStartDay - 1..previousMonthLength) {
                daysInMonthArray.add(
                    DayState(
                        LocalDate.of(previousMonth.year, previousMonth.month, i),
                        i.toString(),
                        0,
                        isOverlap = false,
                        isVisible = false,
                        isSelected = false
                    )
                )
            }

            // 현재 달의 날짜 추가
            for (i in 1..lastDayOfMonth.dayOfMonth) {
                daysInMonthArray.add(
                    DayState(
                        LocalDate.of(date.year, date.month, i),
                        i.toString(),
                        0,
                        isOverlap = false,
                        isVisible = true,
                        isSelected = LocalDate.of(date.year, date.month, i) == date
                    )
                )
            }

            // 다음 달의 날짜 추가
            val daysToAdd = 42 - daysInMonthArray.size
            for (i in 1..daysToAdd) {
                daysInMonthArray.add(
                    DayState(
                        LocalDate.of(nextMonth.year, nextMonth.month, i),
                        i.toString(),
                        0,
                        isOverlap = false,
                        isVisible = false,
                        isSelected = false
                    )
                )
            }

            return daysInMonthArray
        }

        @Deprecated("Use daysInWeekArray instead")
        fun daysInWeekArray(date: LocalDate): List<DayState> {
            val startOfWeek = date.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY))
            val endOfWeek = date.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY))

            val daysOfWeek = mutableListOf<DayState>()
            var currentDate = startOfWeek

            while (!currentDate.isAfter(endOfWeek)) {
                val dayState = DayState(
                    currentDate,
                    currentDate.dayOfMonth.toString(),
                    0, // percent
                    isOverlap = false, // isOverlap
                    isVisible = true, // isVisible
                    isSelected = currentDate == date
                )
                daysOfWeek.add(dayState)
                currentDate = currentDate.plusDays(1)
            }

            return daysOfWeek
        }

        private fun sundayForDate(current: LocalDate): LocalDate? {
            var current = current
            val oneWeekAgo = current.minusWeeks(1)
            while (current.isAfter(oneWeekAgo)) {
                if (current.dayOfWeek == DayOfWeek.SUNDAY) return current
                current = current.minusDays(1)
            }
            return null
        }
    }
}