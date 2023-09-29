import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthCheckButton extends StatelessWidget {
  final bool isChecked;
  final void Function() onPressed;

  const AuthCheckButton({
    super.key,
    required this.isChecked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        isChecked ? 'assets/icons/checked.svg' : 'assets/icons/unchecked.svg',
        width: 36,
        height: 36,
      ),
    );
  }
}
