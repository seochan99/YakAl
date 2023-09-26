import 'package:flutter/material.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Profile/ProfileHeader/profie_header_text_widget.dart';
import 'package:yakal/widgets/Profile/ProfileHeader/profile_header_share_widget.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.userViewModel,
  });

  final UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height 240px
      // height: 260,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 88, 20, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileHeaderText(userViewModel: userViewModel),
            const SizedBox(height: 30),
            const ProfileHeaderShareButton(),
          ],
        ),
      ),
      // ROW BACCK GORUND WHITE
    );
  }
}
