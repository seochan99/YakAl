import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingTimeSelectionWidget extends StatefulWidget {
  const SettingTimeSelectionWidget({Key? key}) : super(key: key);

  @override
  _SettingTimeSelectionWidgetState createState() =>
      _SettingTimeSelectionWidgetState();
}

class _SettingTimeSelectionWidgetState
    extends State<SettingTimeSelectionWidget> {
  // 고정 시간 범위
  Map<String, String> timeRanges = {
    '아침': '7:00 - 11:00',
    '점심': '11:00 - 17:00',
    '저녁': '17:00 - 23:00'
  };

  // 선택 시간 범위
  Map<String, String> selectedTimes = {
    '아침': '7:00 - 11:00',
    '점심': '11:00 - 17:00',
    '저녁': '17:00 - 23:00'
  };

  // 시간 선택 함수
  void _selectTime(String period) async {
    // 시간 선택 팝업창
    TimeRange? selectedTime = await _showTimePicker(
      context,
      selectedTimes[period],
    );

    //  만약 시간이 선택되었다면 시간 업데이트
    if (selectedTime != null) {
      setState(() {
        selectedTimes[period] =
            '${selectedTime.startTime} - ${selectedTime.endTime}';
      });
    }
  }

  // 시간 picker 함수
  Future<TimeRange?> _showTimePicker(
      BuildContext context, String? defaultTime) async {
    // 시간 범위를 시작 시간과 끝 시간으로 나누기
    List<String> timeComponents = (defaultTime ?? '00:00').split(' - ');

    // Extract numeric components for hours and minutes
    List<String> startTimeComponents = timeComponents[0].split(':');
    List<String> endTimeComponents = timeComponents[1].split(':');

    int startHours = int.parse(startTimeComponents[0]);
    int startMinutes = int.parse(startTimeComponents[1]);

    int endHours = int.parse(endTimeComponents[0]);
    int endMinutes = int.parse(endTimeComponents[1]);

    TimeOfDay initialStartTime =
        TimeOfDay(hour: startHours, minute: startMinutes);
    TimeOfDay initialEndTime = TimeOfDay(hour: endHours, minute: endMinutes);

    //  시작 시간과 끝 시간을 선택
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: initialStartTime,
    );

    // 만약 시작 시간이 선택되지 않았다면 null 반환
    if (startTime == null) return null;

    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: initialEndTime,
    );

    if (endTime == null) return null;

    return TimeRange(
      startTime: '${startTime.hour}:${startTime.minute}',
      endTime: '${endTime.hour}:${endTime.minute}',
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
  final String endTime;

  TimeRange({required this.startTime, required this.endTime});
}
