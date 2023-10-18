import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/style/color_styles.dart';

class CustomizedBackAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function()? onPressed;
  final String title;

  const CustomizedBackAppBar({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      surfaceTintColor: ColorStyles.white,
      backgroundColor: ColorStyles.white,
      automaticallyImplyLeading: false,
      leadingWidth: 90,
      leading: onPressed == null
          ? null
          : TextButton.icon(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor: ColorStyles.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              icon: SvgPicture.asset("assets/icons/back.svg"),
              label: const Text(
                "뒤로",
                style: TextStyle(
                  color: ColorStyles.gray5,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              onPressed: onPressed,
            ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
