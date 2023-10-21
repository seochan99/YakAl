import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Home/home_view_model.dart';
import 'package:yakal/widgets/Home/pill_floating_action_buttom.dart';
import 'package:yakal/widgets/Home/home_info_layout.dart';

import '../../widgets/Home/home_pill_todo_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              // Padding(
              //   padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              //   child: IconButton(
              //     splashColor: Colors.transparent,
              //     highlightColor: Colors.transparent,
              //     onPressed: () {},
              //     icon: SvgPicture.asset(
              //       'assets/icons/icon-home-notification.svg',
              //     ),
              //   ),
              // ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                /* ----------------- 홈 정보 뷰 -----------------  */
                HomeInfoLayout(viewModel),
                /* ----------------- 구분선 -----------------  */
                Container(
                    // width 꽉 차게
                    width: double.infinity,
                    height: 2,
                    decoration: const BoxDecoration(color: Color(0xffe9e9ee))),
                /* ----------------- TodoList 뷰 -----------------  */
                Expanded(child: HomePillTodoView(viewModel: viewModel)),
              ],
            ),
          ),
        ),
        PillFloatingActionButton(viewModel)
      ]),
    );
  }
}
