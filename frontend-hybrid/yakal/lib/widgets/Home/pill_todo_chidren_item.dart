import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_children.dart';

class PillTodoChildrenItem extends StatefulWidget {
  final DateTime todoDate;
  final ETakingTime eTakingTime;
  final PillTodoChildren pillTodoChildren;
  final Function(ETakingTime, int) onClickChildrenCheckBox;
  final Function(String, String)? onClickChildrenItemView;

  const PillTodoChildrenItem(
      {required this.todoDate,
      required this.eTakingTime,
      required this.pillTodoChildren,
      required this.onClickChildrenCheckBox,
      this.onClickChildrenItemView,
      Key? key})
      : super(key: key);

  @override
  State<PillTodoChildrenItem> createState() => _PillTodoChildrenItemState();
}

class _PillTodoChildrenItemState extends State<PillTodoChildrenItem> {
  late final DateTime todoDate;
  late final ETakingTime eTakingTime;
  late final PillTodoChildren pillTodoChildren;
  late final Function(ETakingTime, int) onClickChildrenCheckBox;
  late final Function(String, String)? onClickChildrenItemView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoDate = widget.todoDate;
    eTakingTime = widget.eTakingTime;
    pillTodoChildren = widget.pillTodoChildren;
    onClickChildrenCheckBox = widget.onClickChildrenCheckBox;
    onClickChildrenItemView = widget.onClickChildrenItemView;
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
                        'assets/icons/icon-check-on-36.svg',
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
                  pillTodoChildren.name.length > 16
                      ? '${pillTodoChildren.name.substring(0, 11)}...'
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
            InkWell(
              onTap: () {
                // 3일이 지난 경우 수정 불가능
                if (DateTime.now().difference(todoDate).inDays > 3) {
                  Get.snackbar('복약 기록', '3일이 지나면 수정이 불가능해요!',
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      duration: const Duration(seconds: 1, microseconds: 500),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ColorStyles.gray1,
                      colorText: Colors.black);
                }
                // 오늘 날짜보다 이후인 경우 수정 불가능
                else if (DateTime.now().difference(todoDate).inDays < 0) {
                  Get.snackbar('복약 기록', '미래의 복약 기록을 작성하는 것은 불가능해요.',
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      duration: const Duration(seconds: 1, microseconds: 500),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ColorStyles.gray1,
                      colorText: Colors.black);
                }
                // 복약 기록 수정 가능
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
                    ? SvgPicture.asset('assets/icons/icon-check-oval-on-24.svg')
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
}
