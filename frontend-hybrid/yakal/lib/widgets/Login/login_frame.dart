import 'package:flutter/material.dart';

class LoginFrame extends StatelessWidget {
  final Color outer;
  final Color inner;
  final Widget child;
  final PreferredSizeWidget? appBar;

  const LoginFrame({
    required this.child,
    required this.outer,
    required this.inner,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: outer,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: inner,
          appBar: appBar,
          body: child,
        ),
      ),
    );
  }
}
