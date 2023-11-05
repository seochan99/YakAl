import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/viewModels/Home/home_view_model.dart';
import 'package:yakal/widgets/Home/home_info_layout.dart';
import 'package:yakal/widgets/Home/pill_floating_action_buttom.dart';

import '../../widgets/Home/home_pill_todo_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// device 토큰 저장
Future<void> sendDeviceToken(String deviceToken) async {
  try {
    Map<String, dynamic> requestBody = {
      'device_token': deviceToken,
      'is_ios': false
    };

    var dio = await authDioWithContext();
    var response = await dio.put("/user/device", data: requestBody);

    if (response.statusCode == 200) {
      print('sendDeviceToken - Success');
    } else {
      print('sendDeviceToken - Failure: ${response.statusCode}');
    }
  } catch (error) {}
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    sendDeviceToken(deviceToken);

    // 앱이 열려 있을때 알림 받기
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {}
      }
    });

    // 앱이 백그라운드 상태일때 알림 받기
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

      //im gonna have an alertdialog when clicking from push notification
      Alert(
        context: context,
        type: AlertType.info,
        style: const AlertStyle(
          backgroundColor: Colors.white,
          titleStyle: TextStyle(color: Colors.black),
          descStyle: TextStyle(color: Colors.black),
        ),
        title: title,
        // title from push notification data
        desc: description,
        // description from push notifcation data

        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "확인",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    });

    // 앱이 완전히 종료된 상태에서 알림을 클릭하여 앱을 열었을때 알림 받기
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          viewModel.onClickOutOfPillAddMenu();
        },
        child: Stack(children: [
          SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      color: Colors.white,
                    ),
                    /* ----------------- 홈 정보 뷰 -----------------  */
                    HomeInfoLayout(viewModel),
                    /* ----------------- 구분선 -----------------  */
                    Container(
                        // width 꽉 차게
                        width: double.infinity,
                        height: 2,
                        decoration:
                            const BoxDecoration(color: Color(0xffe9e9ee))),
                    /* ----------------- TodoList 뷰 -----------------  */
                    Expanded(child: HomePillTodoView(viewModel: viewModel)),
                  ],
                ),
              ),
            ),
          ),
          PillFloatingActionButton(viewModel)
        ]),
      ),
    );
  }

  //get device token to use for push notification
  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }
}
