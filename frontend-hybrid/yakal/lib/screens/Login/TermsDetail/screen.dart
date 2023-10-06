import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/TermsDetail/style.dart';
import 'package:yakal/widgets/Login/outer_frame.dart';

import '../../../utilities/style/color_styles.dart';

class TermsDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const TermsDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          title: Text(
            title,
            style: TermsDetailStyle.title,
          ),
          backgroundColor: ColorStyles.white,
          automaticallyImplyLeading: true,
          leadingWidth: 72,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: GestureDetector(
              child: SvgPicture.asset(
                "assets/icons/x-mark.svg",
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: TermsDetailStyle.content,
          ),
        ),
      ),
    );
  }
}
