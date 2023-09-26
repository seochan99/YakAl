import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('홈'),
          SvgPicture.asset(
            'assets/icons/icon-health.svg',
            width: 160,
            height: 160,
          ),
        ],
      ),
    );
  }
}
