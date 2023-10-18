import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Home/home_view_model.dart';
import 'package:yakal/widgets/Home/pill_floating_action_buttom.dart';
import 'package:yakal/widgets/Home/home_info_layout.dart';

import '../../widgets/Home/pill_todo_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = Get.put(HomeViewModel());

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
                Expanded(child: PillTodoLayout(viewModel)),
              ],
            ),
          ),
        ),
        PillFloatingActionButton(viewModel)
      ]),
    );
  }
}
