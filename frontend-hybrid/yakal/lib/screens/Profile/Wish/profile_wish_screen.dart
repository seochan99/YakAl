import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Profile/Wish/profile_wish_done.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class ProfileWishScreen extends StatefulWidget {
  const ProfileWishScreen({super.key});

  @override
  State<ProfileWishScreen> createState() => _ProfileWishScreenState();
}

class _ProfileWishScreenState extends State<ProfileWishScreen> {
  final TextEditingController _opinionController = TextEditingController();

  @override
  void dispose() {
    _opinionController.dispose();
    super.dispose();
  }

  void handleButtonPress() {
    final String opinion = _opinionController.text;
    // opinion server에 전송
    _opinionController.clear();

    // ProfileWishDone Screen 으로 이동
    Get.off(() => const ProfileWishDoneScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: "약알에게 바라는 점",
          ),
        ),
        body: Container(
          color: ColorStyles.white,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '더 나은 약알을 위해\n',
                                  style: TextStyle(
                                    color: Color(0xFF151515),
                                    fontSize: 24,
                                    fontFamily: 'SUIT',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '소중한 의견',
                                  style: TextStyle(
                                    color: Color(0xFF151515),
                                    fontSize: 24,
                                    fontFamily: 'SUIT',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: '을 남겨주세요!',
                                  style: TextStyle(
                                    color: Color(0xFF151515),
                                    fontSize: 24,
                                    fontFamily: 'SUIT',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          // textfield
                          TextField(
                            // height
                            maxLines: 8,
                            controller: _opinionController,
                            decoration: InputDecoration(
                              hintText: '특정 주제의 도배글, 내용없는 글쓰기는 자제해주세요.',
                              hintStyle: const TextStyle(
                                color: ColorStyles.gray3,
                                fontSize: 16,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: ColorStyles.gray2,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: ColorStyles.gray2,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: ColorStyles.main,
                                  width: 2,
                                ),
                              ),
                            ),
                          ), // 의견 남기기 버튼
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  0.0,
                  20.0,
                  30,
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _opinionController,
                  builder: (context, value, child) {
                    final isButtonEnabled = value.text.isNotEmpty;

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: isButtonEnabled
                            ? const Color(0xff2666f6)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: isButtonEnabled ? handleButtonPress : null,
                      child: const Text("의견 남기기",
                          style: TextStyle(fontSize: 20.0)),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
