import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  bool alertToggleValue = false;

  @override
  void initState() {
    super.initState();
    // Load the alert toggle value from shared preferences
    _loadAlertToggleValue();
  }

  Future<void> _loadAlertToggleValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      alertToggleValue = prefs.getBool('alertToggleValue') ?? false;
    });
  }

  Future<void> _saveAlertToggleValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alertToggleValue', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: "알림 설정",
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(children: [
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '복약 알림',
                        style: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 16,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '등록한 약의 복용 알림',
                        style: TextStyle(
                          color: ColorStyles.gray4,
                          fontSize: 14,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  // Altered to use GetBuilder for reactive UI updates

                  Switch(
                    value: alertToggleValue,
                    onChanged: (value) {
                      setState(() {
                        alertToggleValue = value;
                        // Save the updated toggle value to shared preferences
                        _saveAlertToggleValue(value);
                      });
                    },
                    inactiveTrackColor: ColorStyles.gray3,
                    inactiveThumbColor: ColorStyles.white,
                    // border none

                    activeTrackColor: ColorStyles.main,
                    activeColor: Colors.white,
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
