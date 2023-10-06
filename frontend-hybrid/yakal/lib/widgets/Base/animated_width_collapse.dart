import 'package:flutter/cupertino.dart';

class AnimatedWidthCollapse extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Duration duration;

  const AnimatedWidthCollapse({
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      child: Container(
        constraints: visible
            ? const BoxConstraints(maxWidth: double.infinity)
            : const BoxConstraints(maxWidth: 0),
        child: visible ? child : Container(),
      ),
    );
  }
}
