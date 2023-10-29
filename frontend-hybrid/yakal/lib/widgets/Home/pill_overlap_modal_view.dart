import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Home/pill_overlap_item.dart';

import '../../models/Home/pill_todo_children.dart';

class PillOverlapModalView extends StatelessWidget {
  final Map<String, List<PillTodoChildren>> overlapInfo;
  const PillOverlapModalView({
    Key? key,
    required this.overlapInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                child: Text(
                  "성분이 같은 중복된 약물이 있어요!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorStyles.black,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset('assets/icons/close.svg'))
              //
            ],
          ),
          SizedBox.fromSize(size: const Size(0, 10)),
          Expanded(
              child: CustomScrollView(slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return PillOverlapParentItem(
                    atcCode: overlapInfo.keys.toList()[index],
                    pillTodoChildrenList: overlapInfo.values.toList()[index],
                  );
                },
                childCount: overlapInfo.length,
              ),
            ),
          ])),
        ],
      ),
    );
  }

  List<_PillOverLap> _getOverLapList() {
    // overlapInfo List로 변경
    List<_PillOverLap> overlapList = [];

    overlapInfo.forEach((key, value) {
      overlapList.add(_PillOverLap(atcCode: key, pillTodoChildren: value));
    });

    print(overlapList);

    return overlapList;
  }
}

class _PillOverLap {
  final String atcCode;
  final List<PillTodoChildren> pillTodoChildren;
  const _PillOverLap({
    required this.atcCode,
    required this.pillTodoChildren,
  });
}
