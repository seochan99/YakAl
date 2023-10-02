import 'package:flutter/material.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class InfoBohoScreen extends StatelessWidget {
  const InfoBohoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "보호자 정보"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '보호자 정보',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                Text(
                  '보호자 정보를 입력해주세요.\n',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                // InfoBohoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
