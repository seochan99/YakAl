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
                addAutomaticKeepAlives: true,
                itemCount: viewModel.pillTodoParents.length + 1,
                itemBuilder: (context, index) {
                  if (index == viewModel.pillTodoParents.length) {
                    return const SizedBox(
                      height: 100,
                    );
                  } else {
                    return PillTodoParentItem(
                      isDetail: viewModel.isDetail,
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
                        viewModel.onClickChildrenCheckBox(eTakingTime, todoId);
                      },
                      onClickChildrenItemView: (String name, String kdCode) {
                        if (kdCode.isNotEmpty) {
                          Get.toNamed('/pill/detail', arguments: {
                            'name': name,
                            'kdCode': kdCode,
                          });
                        } else {
                          Get.snackbar(
                            '약 상세 정보',
                            '약알에 등록된 전문의약품이 아닙니다.',
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            duration:
                                const Duration(seconds: 1, milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: ColorStyles.gray1,
                            colorText: Colors.black,
                          );
                        }
                      },
                    );
                  }
                },
              ));
  }
}
