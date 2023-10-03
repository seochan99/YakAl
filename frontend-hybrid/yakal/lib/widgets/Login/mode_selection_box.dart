import 'package:flutter/material.dart';

class ModeSelectionBox extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  const ModeSelectionBox({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }
}
