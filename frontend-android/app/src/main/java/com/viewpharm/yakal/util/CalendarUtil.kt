package com.viewpharm.yakal.util

import com.viewpharm.yakal.model.CalendarTaking
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.DateTimeFormatter
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
        fun daysInMonthArray(date: LocalDate): List<CalendarTaking> {
            val daysInMonthArray = ArrayList<CalendarTaking>()
            val yearMonth = YearMonth.from(date)
            val daysInMonth = yearMonth.lengthOfMonth()
            val firstOfMonth: LocalDate = date.withDayOfMonth(1)
            val dayOfWeek = firstOfMonth.dayOfWeek.value
            val random = Random

            for (i in 1..42) {
                if (i <= dayOfWeek || i > daysInMonth + dayOfWeek) {
                    daysInMonthArray.add(CalendarTaking(0, "", false))
                } else {
                    daysInMonthArray.add(
                        CalendarTaking(
                            random.nextInt(101),
                            (i - dayOfWeek).toString(),
                            random.nextInt(101) % 3 == 0
                        )
                    )
                }
            }
            return daysInMonthArray
        }

        @Deprecated("Use daysInWeekArray instead")
        fun daysInWeekArray(date: LocalDate): List<CalendarTaking> {
            val daysInWeekArray = ArrayList<CalendarTaking>()
            var current = sundayForDate(date)
            val endDate = current!!.plusWeeks(1)
            val random = Random

            while (current!!.isBefore(endDate)) {
                daysInWeekArray.add(
                    CalendarTaking(
                        random.nextInt(101),
                        (current.format(DateTimeFormatter.ofPattern("dd"))),
                        random.nextInt(101) % 3 == 0
                    )
                )

                current = current.plusDays(1)
            }
            return daysInWeekArray
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