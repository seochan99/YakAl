import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

enum ETakingTime {
  breakfast,
  lunch,
  dinner,
}

// ETakingTime 확장, 아침, 점심, 저녁, 이름, 시작 시간, 끝 시간, 시간대
extension ETakingTimeExtension on ETakingTime {
  String get korName {
    switch (this) {
      case ETakingTime.breakfast:
        return '아침';
      case ETakingTime.lunch:
        return '점심';
      case ETakingTime.dinner:
        return '저녁';
    }
  }

// 영어 이름
  String get engName {
    switch (this) {
      case ETakingTime.breakfast:
        return 'breakfast';
      case ETakingTime.lunch:
        return 'lunch';
      case ETakingTime.dinner:
        return 'dinner';
    }
  }

  TimeOfDay get startTime {
    switch (this) {
      case ETakingTime.breakfast:
        return const TimeOfDay(hour: 7, minute: 0);
      case ETakingTime.lunch:
        return const TimeOfDay(hour: 11, minute: 0);
      case ETakingTime.dinner:
        return const TimeOfDay(hour: 17, minute: 0);
    }
  }

  // endtime
  TimeOfDay get endTime {
    switch (this) {
      case ETakingTime.breakfast:
        return const TimeOfDay(hour: 10, minute: 59);
      case ETakingTime.lunch:
        return const TimeOfDay(hour: 16, minute: 59);
      case ETakingTime.dinner:
        return const TimeOfDay(hour: 23, minute: 59);
    }
  }

  // iconpath
  String get iconPath {
    switch (this) {
      case ETakingTime.breakfast:
        return 'assets/icons/icon-morning.svg';
      case ETakingTime.lunch:
        return 'assets/icons/icon-afternoon.svg';
      case ETakingTime.dinner:
        return 'assets/icons/icon-evening.svg';
    }
  }
}

class SettingTimeSelectionWidget extends StatefulWidget {
  const SettingTimeSelectionWidget({Key? key}) : super(key: key);
  // userviewModel
  UserViewModel get userViewModel => Get.find<UserViewModel>();

  @override
  _SettingTimeSelectionWidgetState createState() =>
      _SettingTimeSelectionWidgetState();
}

class _SettingTimeSelectionWidgetState
    extends State<SettingTimeSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimeRow(ETakingTime.breakfast),
        _buildTimeRow(ETakingTime.lunch),
        _buildTimeRow(ETakingTime.dinner),
      ],
    );
  }

  Widget _buildTimeRow(
    ETakingTime takingTime,
  ) {
    return InkWell(
      onTap: () {
        // 타임피커 열림
        showTimePicker(
          context: context,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF424242), // Dark grey for body text
                  onPrimary: Color(0xFF0D47A1), // Darker blue for header text
                  surface: Color(0xFFF5F5F5), // Light grey for background
                  onSurface: Color(0xFF424242), // Dark grey for body text
                ),
                dialogBackgroundColor: const Color(
                    0xFFF5F5F5), // Light grey for the TimePicker background
              ),
              child: child!,
            );
          },
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value != null) {
            var startTimeMin =
                takingTime.startTime.hour * 60 + takingTime.startTime.minute;
            var endTimeMin =
                takingTime.endTime.hour * 60 + takingTime.endTime.minute;
            var valueMin = value.hour * 60 + value.minute;
            if (valueMin < startTimeMin || valueMin > endTimeMin) {
              Get.snackbar(
                '${takingTime.korName} 시간대를 벗어났어요',
                '${takingTime.startTime.hour}시 ~ ${takingTime.endTime.hour}시 사이의 시간을 선택해주세요!',
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                duration: const Duration(milliseconds: 1500),
                snackPosition: SnackPosition.TOP,
                backgroundColor: ColorStyles.gray1,
                colorText: Colors.black,
              );
              return;
            }

            // takingTime.startTime 이랑 takingTime.endTime 사이를 입력했는지 확인, 아니면 경고창 띄우기
            // TimeofDay끼리 시간, 분 비교하기

            // 타임피커에서 선택한 시간을 저장
            widget.userViewModel.setMyTime(
              takingTime,
              value,
            );
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      takingTime.iconPath,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 8),
            Text(
              takingTime.korName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${takingTime.startTime.format(context)} ~ ${takingTime.endTime.format(context)}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff90909F),
              ),
            ),
            const Spacer(),
            Obx(
              () => Text(
                widget.userViewModel.getMyTime(takingTime),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorStyles.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}

class TimeRange {
  final String startTime;

  TimeRange({required this.startTime});
}
