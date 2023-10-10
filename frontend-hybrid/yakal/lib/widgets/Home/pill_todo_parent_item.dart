import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/widgets/Home/pill_todo_chidren_item.dart';

class PillTodoParentItem extends StatefulWidget {
  final PillTodoParent pillTodoParent;
  final Function(ETakingTime) onClickParentCheckBox;
  final Function(ETakingTime) onClickParentItemView;
  final Function(ETakingTime, int) onClickChildrenCheckBox;
  final Function(ETakingTime, int) onClickChildrenItemView;

  const PillTodoParentItem(
      {required this.pillTodoParent,
      required this.onClickParentCheckBox,
      required this.onClickParentItemView,
      required this.onClickChildrenCheckBox,
      required this.onClickChildrenItemView,
      Key? key})
      : super(key: key);

  @override
  State<PillTodoParentItem> createState() => _PillTodoParentItemState();
}

class _PillTodoParentItemState extends State<PillTodoParentItem> {
  @override
  Widget build(BuildContext context) {
    return widget.pillTodoParent.eTakingTime == ETakingTime.INVISIBLE
        ? const SizedBox(
            width: 60,
            height: 80,
          )
        : Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    decoration: widget.pillTodoParent.isExpanded
                        ? const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.blue)),
                            color: Colors.white)
                        : const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            color: Colors.white,
                          ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        onExpansionChanged: (newState) {
                          widget.onClickParentItemView(
                              widget.pillTodoParent.eTakingTime);
                        },
                        trailing: const SizedBox(),
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
                              child: widget.pillTodoParent.isExpanded
                                  ? SvgPicture.asset(
                                      'assets/icons/icon-pill-on.svg')
                                  : SvgPicture.asset(
                                      'assets/icons/icon-pill-off.svg'),
                            ),
                            SizedBox.fromSize(size: const Size(8, 8)),
                            Text(
                              widget.pillTodoParent.eTakingTime.time,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      'assets/fonts/Pretendard-SemiBold.otf'),
                            ),
                            SizedBox.fromSize(size: const Size(8, 8)),
                            Text(
                              widget.pillTodoParent.getTotalCnt(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF90909F),
                                  fontFamily:
                                      'assets/fonts/Pretendard-SemiBold.otf'),
                            ),
                            //오른쪽 정렬된 Text
                            const Spacer(),
                            Text(
                              '복용완료',
                              style: widget.pillTodoParent.isCompleted
                                  ? const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF2666F6),
                                      fontFamily:
                                          'assets/fonts/Pretendard-SemiBold.otf')
                                  : const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF90909F),
                                      fontFamily:
                                          'assets/fonts/Pretendard-SemiBold.otf'),
                            ),
                            // CheckBox
                            SizedBox.fromSize(size: const Size(8, 8)),
                            InkWell(
                              onTap: () {
                                widget.onClickParentCheckBox(
                                    widget.pillTodoParent.eTakingTime);
                              },
                              // InkWell Repple Effect 없애기
                              splashColor: Colors.transparent,
                              child: Container(
                                width: 48,
                                height: 48,
                                child: widget.pillTodoParent.isCompleted
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
                          if (widget.pillTodoParent.isOverLap)
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
                            itemCount: widget.pillTodoParent.todos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PillTodoChildrenItem(
                                eTakingTime: widget.pillTodoParent.eTakingTime,
                                pillTodoChildren:
                                    widget.pillTodoParent.todos[index],
                                onClickChildrenCheckBox: (eTakingTime, todoId) {
                                  widget.onClickChildrenCheckBox(
                                      eTakingTime, todoId);
                                },
                                onClickChildrenItemView: (eTakingTime, todoId) {
                                  widget.onClickChildrenItemView(
                                      eTakingTime, todoId);
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
          );
  }
}
