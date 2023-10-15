import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yakal/screens/Detail/detail_fragment.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class PillDetailScreen extends StatefulWidget {
  const PillDetailScreen({super.key});

  @override
  State<PillDetailScreen> createState() => _PillDetailScreenState();
}

class _PillDetailScreenState extends State<PillDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: "약 세부 정보",
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: false
                          ? SvgPicture.asset(
                              'assets/icons/icon-check-on-36.svg',
                              width: 80,
                              height: 40,
                              color: Colors.blue,
                            )
                          : Image.memory(
                              base64Decode(
                                  "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"),
                              width: 96,
                              height: 48,
                            ),
                    ),
                  ),
                  SizedBox.fromSize(size: const Size(16, 16)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "동화디트로판정",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox.fromSize(size: const Size(8, 8)),
                        const Text(
                          "방광 & 전립선질환 치료제.혹시나 두줄일 경우 행간 22px",
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xff8d8d8d),
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: "복약 정보",
                ),
                Tab(
                  text: "음식/약물",
                ),
                Tab(
                  text: "금기",
                ),
                Tab(
                  text: "신중 투여",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  DetailFragment(),
                  DetailFragment(),
                  DetailFragment(),
                  DetailFragment(),
                ],
              ),
            )
          ],
        ));
  }
}
