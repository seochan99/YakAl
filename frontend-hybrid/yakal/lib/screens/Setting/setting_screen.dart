import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      appBar: AppBar(
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
              ListTile(
                title: const Text('# 일반 모드'),
                subtitle: const Text('약알의 일반적인 모드입니다.'),
                onTap: () {
                  // Save the selected mode to the device here
                },
              ),
              ListTile(
                title: const Text('# 라이트 모드'),
                subtitle: const Text('시니어를 위한 쉬운 모드입니다. 다제약물 정보가 포함되어 있습니다.'),
                onTap: () {
                  // Save the selected mode to the device here
                },
              ),
              const SizedBox(
                height: 64,
              ),
              /* -------------- 모드 설정  -------------- */
              const Text("시간 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              // const ListTile(
              //   title: Text('# 시간 설정'),
              //   subtitle: Text('나의 루틴에 맞추어 시간을 조정할 수 있습니다.'),
              // ),
              const ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text('아침'),
                subtitle: Text('시간 >'),
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
