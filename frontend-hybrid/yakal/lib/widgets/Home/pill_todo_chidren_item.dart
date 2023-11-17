import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/circle_widget.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_children.dart';

class PillTodoChildrenItem extends StatefulWidget {
  final bool isDetail;
  final DateTime todoDate;
  final ETakingTime eTakingTime;
  final PillTodoChildren pillTodoChildren;
  final Function(ETakingTime, int) onClickChildrenCheckBox;
  final Function(String, String)? onClickChildrenItemView;

  final bool isModal;

  const PillTodoChildrenItem(
      {required this.isDetail,
      required this.todoDate,
      required this.eTakingTime,
      required this.pillTodoChildren,
      required this.onClickChildrenCheckBox,
      this.onClickChildrenItemView,
      required this.isModal,
      Key? key})
      : super(key: key);

  @override
  State<PillTodoChildrenItem> createState() => _PillTodoChildrenItemState();
}

class _PillTodoChildrenItemState extends State<PillTodoChildrenItem> {
  late final bool isDetail;
  late final DateTime todoDate;
  late final ETakingTime eTakingTime;
  late final PillTodoChildren pillTodoChildren;
  late final Function(ETakingTime, int) onClickChildrenCheckBox;
  late final Function(String, String)? onClickChildrenItemView;

  late final bool isModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDetail = widget.isDetail;
    todoDate = widget.todoDate;
    eTakingTime = widget.eTakingTime;
    pillTodoChildren = widget.pillTodoChildren;
    onClickChildrenCheckBox = widget.onClickChildrenCheckBox;
    onClickChildrenItemView = widget.onClickChildrenItemView;
    isModal = widget.isModal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClickChildrenItemView?.call(
            pillTodoChildren.name, pillTodoChildren.kdCode);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.fromSize(size: const Size(5, 20)),
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: pillTodoChildren.base64Image.isEmpty
                    ? SvgPicture.asset(
                        'assets/icons/img-mainpill-default.svg',
                        width: 80,
                        height: 40,
                      )
                    : Container(
                        width: 80,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CachedMemoryImage(
                          uniqueKey:
                              'app://image/dose/${pillTodoChildren.kdCode}',
                          base64: pillTodoChildren.base64Image,
                          placeholder: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )),
            SizedBox.fromSize(size: const Size(10, 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pillTodoChildren.name.length > 11
                      ? '${pillTodoChildren.name.substring(0, 10)}...'
                      : pillTodoChildren.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // 글자 수 제한(16글자)
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  pillTodoChildren.effect,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff8d8d8d),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // 위험도 마다 색깔 다르게
            if (isDetail) _riskWidget(pillTodoChildren.atcCode.score),
            SizedBox.fromSize(size: const Size(10, 10)),
            if (!isModal)
              InkWell(
                onTap: () {
                  // 3일 이상 지난 경우
                  if (DateTime.now()
                      .isAfter(todoDate.add(const Duration(days: 3)))) {
                    Get.snackbar(
                      '복약 기록',
                      '3일이 지나면 수정이 불가능해요!',
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      duration: const Duration(seconds: 1, microseconds: 500),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ColorStyles.gray1,
                      colorText: Colors.black,
                    );
                  }
                  // 미래의 날짜인 경우
                  else if (DateTime.now().isBefore(todoDate)) {
                    print("${DateTime.now()} $todoDate");
                    Get.snackbar(
                      '복약 기록',
                      '미래의 복약 기록을 작성하는 것은 불가능해요.',
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      duration: const Duration(seconds: 1, microseconds: 500),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ColorStyles.gray1,
                      colorText: Colors.black,
                    );
                  }
                  // 조건을 만족하는 경우
                  else {
                    onClickChildrenCheckBox(eTakingTime, pillTodoChildren.id);
                  }
                },
                // InkWell Repple Effect 없애기
                splashColor: Colors.transparent,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(24)),
                  width: 48,
                  height: 48,
                  child: pillTodoChildren.isTaken
                      ? SvgPicture.asset(
                          'assets/icons/icon-check-oval-on-24.svg')
                      : SvgPicture.asset(
                          'assets/icons/icon-check-oval-off-24.svg'),
                ),
              ),
            SizedBox.fromSize(size: const Size(5, 20)),
          ],
        ),
      ),
    );
  }

  CircleWidget _riskWidget(int score) {
    return switch (pillTodoChildren.atcCode.score) {
      1 => const CircleWidget(width: 10, height: 10, color: ColorStyles.green),
      2 => const CircleWidget(width: 10, height: 10, color: ColorStyles.yellow),
      3 => const CircleWidget(width: 10, height: 10, color: ColorStyles.red),
      _ => const CircleWidget(width: 10, height: 10, color: ColorStyles.white),
    };
  }
}
