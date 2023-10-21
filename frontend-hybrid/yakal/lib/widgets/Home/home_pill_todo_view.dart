import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Home/pill_todo_parent_item.dart';

import '../../viewModels/Base/pill_todo_viewmodel.dart';

class HomePillTodoView extends StatefulWidget {
  final PillTodoViewModel viewModel;

  const HomePillTodoView({required this.viewModel, Key? key}) : super(key: key);

  @override
  State<HomePillTodoView> createState() => _HomePillTodoViewState();
}

class _HomePillTodoViewState extends State<HomePillTodoView> {
  late final PillTodoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

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
                  const Text("아직 등록된 약이 없네요!",
                      style: TextStyle(fontSize: 16, color: ColorStyles.gray4)),
                  const Text("약 등록을 해주세요!",
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
                  return PillTodoParentItem(
                    todoDate: viewModel.todoDate,
                    pillTodoParent: viewModel.pillTodoParents[index],
                    isOverLap: viewModel
                        .overlapInfoMap[viewModel
                            .pillTodoParents[index].eTakingTime
                            .toString()
                            .split(".")
                            .last]!
                        .isNotEmpty,
                    onClickParentCheckBox: (eTakingTime) {
                      viewModel.onClickParentCheckBox(eTakingTime);
                    },
                    onClickParentItemView: (eTakingTime) {
                      viewModel.onClickParentItemView(eTakingTime);
                    },
                    onClickChildrenCheckBox: (eTakingTime, todoId) {
                      viewModel.onClickChildrenCheckBox(eTakingTime, todoId);
                    },
                    onClickChildrenItemView: (String name, String kdCode) {
                      Get.toNamed('/pill/detail', arguments: {
                        'name': name,
                        'kdCode': kdCode,
                      });
                    },
                  );
                },
              ));
  }
}
