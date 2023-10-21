import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/custom_expansion_tile.dart';
import 'package:yakal/widgets/Home/pill_todo_chidren_item.dart';

class PillTodoParentItem extends StatefulWidget {
  final DateTime todoDate;
  final PillTodoParent pillTodoParent;
  final bool isOverLap;
  final Function(ETakingTime) onClickParentCheckBox;
  final Function(ETakingTime) onClickParentItemView;
  final Function(ETakingTime, int) onClickChildrenCheckBox;
  final Function(String, String)? onClickChildrenItemView;

  const PillTodoParentItem(
      {required this.todoDate,
      required this.pillTodoParent,
      required this.isOverLap,
      required this.onClickParentCheckBox,
      required this.onClickParentItemView,
      required this.onClickChildrenCheckBox,
      this.onClickChildrenItemView,
      Key? key})
      : super(key: key);

  @override
  State<PillTodoParentItem> createState() => _PillTodoParentItemState();
}

class _PillTodoParentItemState extends State<PillTodoParentItem> {
  late final DateTime todoDate;
  late bool isOverLap;
  late final PillTodoParent pillTodoParent;
  late final Function(ETakingTime) onClickParentCheckBox;
  late final Function(ETakingTime) onClickParentItemView;
  late final Function(ETakingTime, int) onClickChildrenCheckBox;
  late final Function(String, String)? onClickChildrenItemView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoDate = widget.todoDate;
    isOverLap = widget.isOverLap;
    pillTodoParent = widget.pillTodoParent;
    onClickParentCheckBox = widget.onClickParentCheckBox;
    onClickParentItemView = widget.onClickParentItemView;
    onClickChildrenCheckBox = widget.onClickChildrenCheckBox;
    onClickChildrenItemView = widget.onClickChildrenItemView;
  }

  @override
  Widget build(BuildContext context) {
    return pillTodoParent.eTakingTime == ETakingTime.INVISIBLE
        ? const SizedBox(
            width: 60,
            height: 80,
          )
        : Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // 변경 가능한 값
                  ),
                ],
              ),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      decoration: pillTodoParent.isExpanded
                          ? const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              border: Border.fromBorderSide(
                                  BorderSide(color: Color(0xFF2666F6))),
                              color: Colors.white)
                          : const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white)),
                              color: Colors.white,
                            ),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: MyExpansionTile(
                          onExpansionChanged: (newState) {
                            onClickParentItemView(pillTodoParent.eTakingTime);
                          },
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          tilePadding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          childrenPadding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 5),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xffE9E9EE),
                                ),
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    3, 3, 3, 3),
                                width: 30,
                                height: 30,
                                child: pillTodoParent.isExpanded
                                    ? SvgPicture.asset(
                                        'assets/icons/icon-pill-on.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/icon-pill-off.svg'),
                              ),
                              SizedBox.fromSize(size: const Size(8, 8)),
                              Text(pillTodoParent.eTakingTime.time,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: ColorStyles.black,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox.fromSize(size: const Size(8, 8)),
                              Text(
                                pillTodoParent.getTotalCnt(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorStyles.gray4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              //오른쪽 정렬된 Text
                              const Spacer(),
                              Text('모두 완료',
                                  style: pillTodoParent.isCompleted
                                      ? const TextStyle(
                                          fontSize: 16,
                                          color: ColorStyles.main,
                                          fontWeight: FontWeight.w700,
                                        )
                                      : const TextStyle(
                                          fontSize: 16,
                                          color: ColorStyles.gray3,
                                          fontWeight: FontWeight.w700,
                                        )),
                              // CheckBox
                              SizedBox.fromSize(size: const Size(8, 8)),
                              InkWell(
                                onTap: () {
                                  // 3일이 지난 경우 수정 불가능
                                  if (DateTime.now()
                                          .difference(todoDate)
                                          .inDays >
                                      3) {
                                    Get.snackbar('복약 기록', '3일이 지나면 수정이 불가능해요!',
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 20),
                                        duration: const Duration(
                                            seconds: 1, microseconds: 500),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: ColorStyles.gray1,
                                        colorText: Colors.black);
                                  }
                                  // 오늘 날짜보다 이후인 경우 수정 불가능
                                  else if (DateTime.now()
                                          .difference(todoDate)
                                          .inDays <
                                      0) {
                                    Get.snackbar(
                                        '복약 기록', '미래의 복약 기록을 작성하는 것은 불가능해요.',
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 20),
                                        duration: const Duration(
                                            seconds: 1, microseconds: 500),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: ColorStyles.gray1,
                                        colorText: Colors.black);
                                  }
                                },
                                // InkWell Repple Effect 없애기
                                splashColor: Colors.transparent,
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: pillTodoParent.isCompleted
                                      ? SvgPicture.asset(
                                          'assets/icons/icon-check-on-36.svg')
                                      : SvgPicture.asset(
                                          'assets/icons/icon-check-off-36.svg'),
                                ),
                              ),
                            ],
                          ),
                          children: [
                            Container(
                                // width 꽉 차게
                                width: MediaQuery.of(context).size.width - 20,
                                height: 2,
                                decoration: const BoxDecoration(
                                    color: Color(0xffe9e9ee))),
                            SizedBox.fromSize(size: const Size(0, 10)),
                            if (isOverLap)
                              Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  height: 40,
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 10),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color(0x1AFF8282),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '약물 중 성분이 같은 중복 약물이 있습니다!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFE01029),
                                          fontFamily:
                                              'assets/fonts/Pretendard-SemiBold.otf'),
                                    ),
                                  )),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: pillTodoParent.todos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PillTodoChildrenItem(
                                  todoDate: todoDate,
                                  eTakingTime: pillTodoParent.eTakingTime,
                                  pillTodoChildren: pillTodoParent.todos[index],
                                  onClickChildrenCheckBox:
                                      (eTakingTime, todoId) {
                                    onClickChildrenCheckBox(
                                        eTakingTime, todoId);
                                  },
                                  onClickChildrenItemView: (name, kdCode) {
                                    onClickChildrenItemView?.call(name, kdCode);
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
