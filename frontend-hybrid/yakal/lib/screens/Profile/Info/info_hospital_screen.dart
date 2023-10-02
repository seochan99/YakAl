import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class InfoHospitalScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  InfoHospitalScreen({super.key});

  @override
  State<InfoHospitalScreen> createState() => _InfoHospitalScreenState();
}

class _InfoHospitalScreenState extends State<InfoHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "병원 기록 추가"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '입원 기록',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),

                        const SizedBox(height: 16),
                        TextButton(
                            // borderRadius: BorderRadius.circular(10),
                            style: TextButton.styleFrom(
                              backgroundColor: ColorStyles.gray1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/plus-circle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 14),
                                const Text(
                                  "입원 기록 추가",
                                  style: TextStyle(
                                      color: ColorStyles.gray5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )),
                        const SizedBox(height: 16),
                        // InfoBohoList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
