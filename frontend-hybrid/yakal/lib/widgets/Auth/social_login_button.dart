import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final Color backgroundColor;
  final Color color;
  final void Function() onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size.fromHeight(64.0),
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: SvgPicture.asset(
              iconPath,
              height: 32,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontFamily: "SUIT",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.685,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
