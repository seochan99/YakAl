import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveyHeaderWidget extends StatelessWidget {
  final String content;
  final String time;
  final String iconPath;

  const SurveyHeaderWidget({
    super.key,
    required this.content,
    required this.time,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF5F5F9),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          iconPath,
          width: 56,
          height: 56,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff626272),
                borderRadius:
                    BorderRadius.circular(8.0), // Adjust the radius as needed
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text("총 $time분 내외",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
