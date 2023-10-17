import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Home/home_view_model.dart';
import 'package:yakal/widgets/Home/pill_floating_action_buttom.dart';
import 'package:yakal/widgets/Home/home_info_layout.dart';
import 'package:yakal/widgets/Home/pill_todo_parent_item.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = Get.put(HomeViewModel());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            //스크롤 내렸을 때 컬러
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/icon-home-notification.svg',
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeInfoLayout(viewModel),
                Container(
                    // width 꽉 차게
                    width: double.infinity,
                    height: 2,
                    decoration: const BoxDecoration(color: Color(0xffe9e9ee))),
                SizedBox.fromSize(
                  size: const Size.fromHeight(10),
                ),
                Expanded(
                    child: Obx(() => ListView.builder(
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
                        }))),
              ],
            ),
          ),
        ),
        PillFloatingActionButton(viewModel)
      ]),
    );
  }
}
