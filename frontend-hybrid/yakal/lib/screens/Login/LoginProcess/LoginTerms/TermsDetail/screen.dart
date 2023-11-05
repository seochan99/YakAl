import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/provider/Login/login_terms_provider.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/TermsDetail/style.dart';
import 'package:yakal/utilities/enum/terms.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class TermsDetailScreen extends StatelessWidget {
  final ETerms terms;
  final LoginTermsProvider loginTermsProvider;

  const TermsDetailScreen({
    super.key,
    required this.terms,
    required this.loginTermsProvider,
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
            terms.title,
            style: TermsDetailStyle.title,
          ),
          surfaceTintColor: ColorStyles.white,
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
          child: FutureBuilder<String>(
            future: loginTermsProvider.loadAsset(terms),
            builder: (context, snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                return const CircularProgressIndicator();
              }

              return Text(
                snapshot.data!,
                style: TermsDetailStyle.content,
              );
            },
          ),
        ),
      ),
    );
  }
}
