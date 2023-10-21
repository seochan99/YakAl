import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Home/pill_todo_parent_item.dart';

import '../../viewModels/Base/pill_todo_viewmodel.dart';

class PillTodoLayout extends StatefulWidget {
  final PillTodoViewModel viewModel;
  final bool isCalendarView;

  const PillTodoLayout(
      {required this.viewModel, required this.isCalendarView, Key? key})
      : super(key: key);

  @override
  State<PillTodoLayout> createState() =>
      _PillTodoLayoutState(viewModel, isCalendarView);
}

class _PillTodoLayoutState extends State<PillTodoLayout> {
  final PillTodoViewModel viewModel;
  final bool isCalendarView;

  _PillTodoLayoutState(this.viewModel, this.isCalendarView);

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.isLoaded
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF2666F6),
            ),
          )
        : viewModel.countModel.totalCount == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("아직 등록된 약이 없네요!",
                      style: TextStyle(fontSize: 16, color: ColorStyles.gray4)),
                  Text("약 등록을 해주세요!",
                      style: TextStyle(fontSize: 16, color: ColorStyles.gray4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.fromSize(size: const Size(205, 10)),
                      SizedBox(
                          width: 100,
                          child:
                              SvgPicture.asset('assets/icons/arrow_pill.svg')),
                    ],
                  )
                ],
              )
            : ListView.builder(
                itemCount: viewModel.pillTodoParents.length,
                itemBuilder: (context, index) {
                  return !isCalendarView
                      ? PillTodoParentItem(
                          pillTodoParent: viewModel.pillTodoParents[index],
                          onClickParentCheckBox: (eTakingTime) {
                            viewModel.onClickParentCheckBox(eTakingTime);
                          },
                          onClickParentItemView: (eTakingTime) {
                            viewModel.onClickParentItemView(eTakingTime);
                          },
                          onClickChildrenCheckBox: (eTakingTime, todoId) {
                            viewModel.onClickChildrenCheckBox(
                                eTakingTime, todoId);
                          },
                          onClickChildrenItemView:
                              (String name, String kdCode) {
                            Get.toNamed('/pill/detail', arguments: {
                              'name': name,
                              'kdCode': kdCode,
                            });
                          },
                        )
                      : PillTodoParentItem(
                          pillTodoParent: viewModel.pillTodoParents[index],
                          onClickParentCheckBox: (eTakingTime) {
                            viewModel.onClickParentCheckBox(eTakingTime);
                          },
                          onClickParentItemView: (eTakingTime) {
                            viewModel.onClickParentItemView(eTakingTime);
                          },
                          onClickChildrenCheckBox: (eTakingTime, todoId) {
                            viewModel.onClickChildrenCheckBox(
                                eTakingTime, todoId);
                          },
                        );
                },
              ));
  }
}
