import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/utilities/api/api.dart';

class SettingTimeSelectionWidget extends StatefulWidget {
  const SettingTimeSelectionWidget({Key? key}) : super(key: key);

  @override
  _SettingTimeSelectionWidgetState createState() =>
      _SettingTimeSelectionWidgetState();
}

class _SettingTimeSelectionWidgetState
    extends State<SettingTimeSelectionWidget> {
  // 고정 시간 범위
  Map<String, String> timeRanges = {'아침': '7:00', '점심': '11:00', '저녁': '17:00'};

  Map<String, String> periodMapping = {
    '아침': 'breakfast',
    '점심': 'lunch',
    '저녁': 'dinner',
  };

  // 선택 시간 범위
  Map<String, String> selectedTimes = {
    '아침': '7:00',
    '점심': '11:00',
    '저녁': '17:00'
  };

  // 시간 선택 함수
  void _selectTime(String period) async {
    TimeRange? selectedTime = await _showTimePicker(
      context,
      selectedTimes[period],
    );

    if (selectedTime != null) {
      setState(() {
        selectedTimes[period] = selectedTime.startTime;
      });

      String timezone =
          periodMapping[period] ?? 'breakfast'; // default to breakfast

      String time = selectedTimes[period] ?? '00:00';

      Map<String, String> data = {
        "timezone": timezone,
        "time": time,
      };

      updateNotificationTime(data);
    }
  }

  // 시간 업데이트 함수
  Future<void> updateNotificationTime(Map<String, String> data) async {
    try {
      var dio = await authDioWithContext();
      await dio.patch("/user/notification-time", data: data);
    } catch (e) {
      throw Exception('Failed to update notification time');
    }
  }

  // 시간 picker 함수
  Future<TimeRange?> _showTimePicker(
      BuildContext context, String? defaultTime) async {
    // 시간 범위를 시작 시간과 끝 시간으로 나누기
    List<String> timeComponents = (defaultTime ?? '00:00').split(' - ');

    List<String> startTimeComponents = timeComponents[0].split(':');
    print(startTimeComponents[0]);
    print(startTimeComponents[1]);

    int startHours = int.parse(startTimeComponents[0]);
    int startMinutes = int.parse(startTimeComponents[1]);

    TimeOfDay initialStartTime =
        TimeOfDay(hour: startHours, minute: startMinutes);

    //  시작 시간과 끝 시간을 선택
    TimeOfDay? startTime = await showTimePicker(
      // colore
      context: context,
      initialTime: initialStartTime,
    );

    // 만약 시작 시간이 선택되지 않았다면 null 반환
    if (startTime == null) return null;

    return TimeRange(
      startTime: '${startTime.hour}:${startTime.minute}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimeRow(
            '아침', 'assets/icons/icon-morning.svg', selectedTimes['아침']),
        _buildTimeRow(
            '점심', 'assets/icons/icon-afternoon.svg', selectedTimes['점심']),
        _buildTimeRow(
            '저녁', 'assets/icons/icon-evening.svg', selectedTimes['저녁']),
      ],
    );
  }

  Widget _buildTimeRow(String period, String iconPath, String? time) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          period,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          time ?? '',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xff90909F),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _selectTime(period),
        ),
      ],
    );
  }
}

class TimeRange {
  final String startTime;

  TimeRange({required this.startTime});
}
