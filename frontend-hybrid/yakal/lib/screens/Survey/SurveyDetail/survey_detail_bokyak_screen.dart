import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveyDetailBokyakScreen extends StatelessWidget {
  const SurveyDetailBokyakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("복약 순응도 테스트",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  /* ----------- Header ----------- */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: const Color(0xffF5F5F9),
                        padding: const EdgeInsets.all(16),
                        child: Row(children: [
                          SvgPicture.asset(
                            'assets/icons/icon-morning.svg',
                            width: 56,
                            height: 56,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '복약을 잘 지키고 계신가요?\n',
                            style: TextStyle(fontSize: 16),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  /* ----------- test content  ----------- */

                  /* ----------- button  ----------- */
                ],
              )),
        ));
  }
}
