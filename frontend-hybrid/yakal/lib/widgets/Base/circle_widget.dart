import 'package:flutter/cupertino.dart';

class CircleWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const CircleWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // 원형 모양
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
