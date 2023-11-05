import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/TermsDetail/style.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class MingamDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const MingamDetailScreen({
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
          centerTitle: true,
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
