import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utilities/style/color_styles.dart';

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
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: AppBar(
              title: Text(
                title,
                style: const TextStyle(
                  color: ColorStyles.black,
                  fontFamily: "SUIT",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
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
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              child: Text(
                content,
                style: const TextStyle(
                  color: ColorStyles.gray6,
                  fontFamily: "SUIT",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
