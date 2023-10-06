import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModels/Home/home_view_model.dart';
import '../../viewModels/Calendar/calendar_viewmodel.dart';
import '../../widgets/Calender/calendar_info_layout.dart';
import '../../widgets/Calender/pill_calender.dart';
import '../../widgets/Home/pill_todo_parent_item.dart';

class CalenderScreen extends StatelessWidget {
  final CalendarViewModel viewModel = Get.put(CalendarViewModel());
  CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///스크롤 내렸을 때 컬러
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: const [],
        title: const Text(
          '다른 날짜 복약정보',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          PillCalender(viewModel),
          Container(
            width: double.infinity,
            height: 2,
            decoration: const BoxDecoration(color: Color(0xFFE9E9EE)),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CalendarInfoLayout(viewModel),
                  Obx(() => ListView.builder(
                      primary: false,
                      shrinkWrap: true,
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
                            viewModel.onClickChildrenCheckBox(
                                eTakingTime, todoId);
                          },
                          onClickChildrenItemView: (eTakingTime, todoId) {
                            print("페이지 이동");
                          },
                        );
                      })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
