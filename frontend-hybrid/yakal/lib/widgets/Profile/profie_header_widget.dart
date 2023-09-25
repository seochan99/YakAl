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
        Text("${userViewModel.user.value.nickName}님,\n약알과 함께 건강하세요!"),
        const Spacer(),
        // 닉네임 수정 네모 버튼 안에는 수정 이라고 글자 적혀있다.
        GestureDetector(
          onTap: () {
            // 닉네임 수정 모달 띄우기
            // showEditNicknameModal = true;
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: const Center(
              child: Text('수정'),
            ),
          ),
        ),
      ],
    );
  }
}
