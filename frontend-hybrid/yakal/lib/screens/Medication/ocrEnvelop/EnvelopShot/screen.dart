import 'package:flutter/material.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

import '../../../../utilities/style/color_styles.dart';

class EnvelopShotScreen extends StatelessWidget {
  const EnvelopShotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 봉투 사진촬영"),
      ),
      body: SafeArea(
        child: Container(
          color: ColorStyles.gray1,
          child: Text("!!"),
        ),
      ),
    );
  }
}
