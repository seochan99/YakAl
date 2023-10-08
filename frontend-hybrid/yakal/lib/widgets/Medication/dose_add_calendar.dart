import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class DoseAddCalendar extends StatefulWidget {
  const DoseAddCalendar({super.key});

  @override
  State<DoseAddCalendar> createState() => _DoseAddCalendarState();
}

class _DoseAddCalendarState extends State<DoseAddCalendar> {
  DateTime _focusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoseAddCalenderController());

    return Obx(() {
      return TableCalendar(
        locale: 'ko-KR',
        focusedDay: _focusedDay,
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        selectedDayPredicate: (day) =>
            isSameDay(controller.selectedDay.value, day),
        rangeStartDay: controller.rangeStart.value,
        rangeEndDay: controller.rangeEnd.value,
        rangeSelectionMode: _rangeSelectionMode,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(controller.selectedDay.value, selectedDay)) {
            setState(() {
              _focusedDay = focusedDay;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
            controller.setSelectedDay(selectedDay);
            controller.setStartDay(null);
            controller.setEndDay(null);
          }
        },
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
          controller.setStartDay(start);
          controller.setEndDay(end);
          controller.setSelectedDay(null);
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          headerPadding: const EdgeInsets.symmetric(vertical: 14.0),
          titleTextStyle: const TextStyle(
            color: ColorStyles.gray5,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          leftChevronIcon: SvgPicture.asset(
            "assets/icons/left-chevron.svg",
            width: 24.0,
            height: 24.0,
          ),
          rightChevronIcon: SvgPicture.asset(
            "assets/icons/right-chevron.svg",
            width: 24.0,
            height: 24.0,
          ),
          leftChevronPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 6,
          ),
          rightChevronPadding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 6,
          ),
        ),
        calendarStyle: CalendarStyle(
          cellPadding: const EdgeInsets.all(8.0),
          cellAlignment: Alignment.center,
          todayTextStyle: const TextStyle(
            color: ColorStyles.main,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          todayDecoration: BoxDecoration(
            color: ColorStyles.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorStyles.main,
              width: 2,
            ),
          ),
          rangeHighlightColor: ColorStyles.sub2,
          rangeStartTextStyle: const TextStyle(
            color: ColorStyles.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          rangeEndTextStyle: const TextStyle(
            color: ColorStyles.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          rangeStartDecoration: const BoxDecoration(
            color: ColorStyles.main,
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: const BoxDecoration(
            color: ColorStyles.main,
            shape: BoxShape.circle,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            const style = TextStyle(
              color: ColorStyles.gray6,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            );

            const sundayStyle = TextStyle(
              color: ColorStyles.red,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            );

            switch (day.weekday) {
              case 1:
                return const Center(
                  child: Text(
                    '월',
                    style: style,
                  ),
                );
              case 2:
                return const Center(
                  child: Text(
                    '화',
                    style: style,
                  ),
                );
              case 3:
                return const Center(
                  child: Text(
                    '수',
                    style: style,
                  ),
                );
              case 4:
                return const Center(
                  child: Text(
                    '목',
                    style: style,
                  ),
                );
              case 5:
                return const Center(
                  child: Text(
                    '금',
                    style: style,
                  ),
                );
              case 6:
                return const Center(
                  child: Text(
                    '토',
                    style: style,
                  ),
                );
              case 7:
                return const Center(
                  child: Text(
                    '일',
                    style: sundayStyle,
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
    });
  }
}

class DoseAddCalenderController extends GetxController {
  final Rxn<DateTime> rangeStart = Rxn<DateTime>(DateTime.now());
  final Rxn<DateTime> rangeEnd =
      Rxn<DateTime>(DateTime.now().add(const Duration(days: 2)));
  final Rxn<DateTime> selectedDay = Rxn<DateTime>(null);

  void setStartDay(DateTime? start) {
    rangeStart.value = start;
  }

  void setEndDay(DateTime? end) {
    rangeEnd.value = end;
  }

  void setSelectedDay(DateTime? day) {
    selectedDay.value = day;
  }

  int getDuration() {
    if (selectedDay.value != null) {
      return 1;
    } else if (rangeStart.value != null && rangeEnd.value != null) {
      return rangeEnd.value!.difference(rangeStart.value!).inDays + 1;
    } else {
      return 0;
    }
  }
}
