import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeaderShareButton extends StatelessWidget {
  const ProfileHeaderShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // backgorund : rgba(233, 233, 238, 1)
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 11, horizontal: 12), // Adjust padding
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(245, 245, 249, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // border none
        side: const BorderSide(
          color: Color.fromRGBO(233, 233, 238, 1),
        ),
      ),
      onPressed: () {
        // Get.toNamed("/login");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/icon-health.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 12),
          const Text('전문가에게 복약정보 공유',
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(98, 98, 114, 1))),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Color.fromRGBO(144, 144, 159, 1)),
        ],
      ),
    );
  }
}
