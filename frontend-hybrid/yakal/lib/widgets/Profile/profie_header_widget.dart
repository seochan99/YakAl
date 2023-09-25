import 'package:flutter/material.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.userViewModel,
  });

  final UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 프로필 사진
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: userViewModel.user.value.nickName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(8, 8, 8,
                      1.0), // This sets the text color to the specified UIColor
                ),
              ),
              const TextSpan(
                text: "님,\n약알과 함께 건강하세요!",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(8, 8, 8,
                      1.0), // This sets the text color to the specified UIColor
                ),
              ),
            ],
          ),
        ),

        const Spacer(),
        // 닉네임 수정 네모 버튼 안에는 수정 이라고 글자 적혀있다.
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 12), // Adjust padding
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromRGBO(233, 233, 238, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // border none
            side: const BorderSide(
              color: Color.fromRGBO(233, 233, 238, 1),
            ),
          ),
          onPressed: () => {},
          child: const Text(
            '수정',
            // color rgba(144, 144, 159, 1)
            // size 14px
            style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(144, 144, 159, 1),
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
