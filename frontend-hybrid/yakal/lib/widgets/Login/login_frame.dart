import 'package:flutter/material.dart';

class LoginFrame extends StatelessWidget {
  final Color outOfSafeAreaColor;
  final Color safeAreaColor;
  final Widget child;
  final PreferredSizeWidget? appBar;

  const LoginFrame({
    required this.child,
    required this.outOfSafeAreaColor,
    required this.safeAreaColor,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: outOfSafeAreaColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: safeAreaColor,
          appBar: appBar,
          body: child,
        ),
      ),
    );
  }
}
