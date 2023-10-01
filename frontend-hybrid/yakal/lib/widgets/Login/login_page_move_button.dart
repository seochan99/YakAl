import 'package:flutter/material.dart';

class LoginPageMoveButton extends StatelessWidget {
  final void Function() onPressed;
  final Color backgroundColor;
  final Color color;
  final String text;

  const LoginPageMoveButton(
    this.text, {
    required this.onPressed,
    required this.backgroundColor,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
