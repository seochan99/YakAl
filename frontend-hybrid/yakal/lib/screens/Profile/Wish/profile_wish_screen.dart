import 'package:flutter/material.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class ProfileWishScreen extends StatelessWidget {
  const ProfileWishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: "약알에게 바라는 점",
        ),
      ),
    );
  }
}
