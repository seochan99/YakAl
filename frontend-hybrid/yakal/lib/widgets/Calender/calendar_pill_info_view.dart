import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utilities/style/color_styles.dart';
import '../../viewModels/Calendar/calendar_viewmodel.dart';
import '../Home/pill_todo_parent_item.dart';
import 'calendar_info_layout.dart';

class CalendarPillInfoView extends StatefulWidget {
  final CalendarViewModel viewModel;
  const CalendarPillInfoView({required this.viewModel, Key? key})
      : super(key: key);

  @override
  State<CalendarPillInfoView> createState() => _CalendarPillInfoViewState();
}

class _CalendarPillInfoViewState extends State<CalendarPillInfoView> {
  late final CalendarViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.isLoaded
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2666F6),
              ),
            ),
          )
        : Expanded(
            child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: CalendarInfoLayout(viewModel),
            ),
            viewModel.countModel.totalCount == 0
                ? SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.fromSize(size: const Size(0, 10)),
                        if (viewModel.todoDate.isBefore(DateTime.now()))
                          const Text("등록된 약이 없네요!",
                              style: TextStyle(
                                  fontSize: 16, color: ColorStyles.gray4))
                        else
                          const Text("아직 등록된 약이 없네요!",
                              style: TextStyle(
                                  fontSize: 16, color: ColorStyles.gray4)),
                      ],
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => PillTodoParentItem(
                        todoDate: viewModel.todoDate,
                        pillTodoParent: viewModel.pillTodoParents[index],
                        isOverLap: viewModel.pillTodoParents[index].isOverLap,
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
                      ),
                      childCount: viewModel.pillTodoParents.length,
                    ),
                  )
          ])));
  }
}
