import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/widgets/Setting/setting_mode_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('앱 설정'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* -------------- 모드 설정  -------------- */
              const Text("모드 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 20),
              const SettingModeWidget(),
              const SizedBox(
                height: 64,
              ),
              /* -------------- 모드 설정  -------------- */
              const Text("시간 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              const Text(
                "나의 루틴에 맞추어 시간을 조정할 수 있습니다.",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff626272),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              const TimeSelectionWidget(),
              Row(
                children: [
                  // "./assets"
                  SvgPicture.asset(
                    "assets/icons/icon-morning.svg",
                    width: 24,
                    height: 24,
                  ),

                  const SizedBox(width: 8),
                  const Text("아침",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(width: 24),
                  const Text("7:00 - 11:00",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff90909F),
                      ))
                ],
              ),
              const ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text('점심'),
                subtitle: Text('시간 >'),
              ),
              const ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text('저녁'),
                subtitle: Text('시간 >'),
              ),

              /* -------------- 계정 설정  -------------- */
              const SizedBox(
                height: 64,
              ),
              const Text("계정 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              ListTile(
                title: const Text('로그아웃'),
                onTap: () {
                  // Implement logout functionality
                },
              ),
              ListTile(
                title: const Text('회원탈퇴'),
                onTap: () {
                  // Implement account deletion functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSelectionWidget extends StatefulWidget {
  const TimeSelectionWidget({Key? key}) : super(key: key);

  @override
  _TimeSelectionWidgetState createState() => _TimeSelectionWidgetState();
}

class _TimeSelectionWidgetState extends State<TimeSelectionWidget> {
  // Default time ranges
  Map<String, String> timeRanges = {
    '아침': '7:00 - 11:00',
    '점심': '11:00 - 17:00',
    '저녁': '17:00 - 23:00'
  };

  // Map to store selected start and end times
  Map<String, String> selectedTimes = {
    '아침': '7:00 - 11:00',
    '점심': '11:00 - 17:00',
    '저녁': '17:00 - 23:00'
  };

  void _selectTime(String period) async {
    // Display a dialog to select start and end time
    TimeRange? selectedTime = await _showTimePicker(
      context,
      selectedTimes[period],
    );

    if (selectedTime != null) {
      setState(() {
        selectedTimes[period] =
            '${selectedTime.startTime} - ${selectedTime.endTime}';
      });
    }
  }

  Future<TimeRange?> _showTimePicker(
      BuildContext context, String? defaultTime) async {
    // Split the defaultTime into hours and minutes
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

    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: initialStartTime,
    );

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
        IconButton(
          icon: const Icon(Icons.edit),
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
