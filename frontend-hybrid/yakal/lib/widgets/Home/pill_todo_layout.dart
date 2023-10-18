// ignore_for_file: no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yakal/widgets/Home/pill_todo_parent_item.dart';

import '../../viewModels/Home/home_view_model.dart';

class PillTodoLayout extends StatefulWidget {
  final HomeViewModel viewModel;

  const PillTodoLayout(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<PillTodoLayout> createState() => _PillTodoLayoutState(viewModel);
}

class _PillTodoLayoutState extends State<PillTodoLayout> {
  final HomeViewModel viewModel;

  _PillTodoLayoutState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.isLoaded == true
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF2666F6),
            ),
          )
        : ListView.builder(
            itemCount: viewModel.pillTodoParents.length,
            itemBuilder: (context, index) {
              return PillTodoParentItem(
                pillTodoParent: viewModel.pillTodoParents[index],
                onClickParentCheckBox: (eTakingTime) {
                  viewModel.onClickParentCheckBox(eTakingTime);
                },
                onClickParentItemView: (eTakingTime) {
                  viewModel.onClickParentItemView(eTakingTime);
                },
                onClickChildrenCheckBox: (eTakingTime, todoId) {
                  viewModel.onClickChildrenCheckBox(eTakingTime, todoId);
                },
                onClickChildrenItemView: (eTakingTime, todoId) {
                  print("페이지 이동");
                },
              );
            }));
  }
}
