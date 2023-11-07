import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/screens/Profile/Appointment/appointment_screen.dart';
import 'package:yakal/screens/Profile/consent/consent_screen.dart';
import 'package:yakal/viewModels/Profile/mingam_controller.dart';

class ProfileHeaderShareButton extends StatelessWidget {
  const ProfileHeaderShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MingamController mingamController = Get.put(MingamController());

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
        if (mingamController.isMingam) {
          Get.to(() => const AppointmentScreen());
        } else {
          Get.to(() => const MingamDetailScreen(title: "민감정보 동의", content: '''

[민감정보 처리 동의서]

서론:
본 동의서는 [회사/앱/서비스명]의 [서비스명] 이용과 관련하여, 사용자의 민감정보를 처리하기 위한 목적으로 작성되었습니다.

정의:
'민감정보'란 개인의 인종, 민족, 사상, 신조, 본적, 거주지의 주소 이외의 정보, 정치적 견해, 범죄기록, 건강, 성생활 등 개인의 중요한 사생활에 관한 정보를 말합니다.

수집하는 민감정보의 종류:
- 건강 정보
- 인종 및 민족 정보
- 기타(구체적으로 명시)

민감정보의 수집 및 이용 목적:
- [목적1]
- [목적2]
- [목적3]

수집한 민감정보의 보유 및 이용 기간:
- [기간] 또는 [조건]

동의 거부 권리 및 동의 거부 시 불이익 내용:
귀하는 본 민감정보 처리에 대하여 동의를 거부할 권리가 있습니다. 동의를 거부하시는 경우 [불이익1], [불이익2] 등의 불이익이 있을 수 있음을 알려드립니다.

동의 방법:
본인은 위의 내용을 모두 이해하였으며, 민감정보의 수집 및 이용에 [동의함] [동의하지 않음] (선택)

추가사항:
[기타 필요한 내용]

[날짜]
[사용자 이름 및 서명]
'''));
        }
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
