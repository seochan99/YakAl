import 'dart:async';

import 'package:yakal/models/Home/overlap_info.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/provider/Home/pill_todo_provider.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_children.dart';

class PillTodoRepository {
  final PillTodoProvider _pillTodoProvider;

  PillTodoRepository({required pillTodoProvider})
      : _pillTodoProvider = pillTodoProvider;

  Future<List<PillTodoParent>> readPillTodoParents(DateTime dateTime) async {
    // API Server 통신
    Map<String, dynamic> response =
        await _pillTodoProvider.getPillTodoParents(dateTime);

    // 이미지를 들고 올 KdCode 중복 삭제
    Set<String> kdCodeSet = {};
    for (var eTakingTime in ETakingTime.values
        .where((element) => element != ETakingTime.INVISIBLE)) {
      List<dynamic> tempData =
          response['schedule'][eTakingTime.toString().split(".").last];

      kdCodeSet.addAll(tempData.map((e) => e['kdcode']));
    }

    // Kims 통신
    Map<String, String> base64ImageMap =
        await _pillTodoProvider.getKimsBase64Image(kdCodeSet);

    // 중복약물 정리
    Map<String, List<OverlapInfo>> overlapResult = {};
    for (var eTakingTime in ETakingTime.values
        .where((element) => element != ETakingTime.INVISIBLE)) {
      List<dynamic> tempData =
          response['overlap'][eTakingTime.toString().split(".").last];

      overlapResult[eTakingTime.toString().split(".").last] =
          OverlapInfo.fromJsonList(tempData);
    }

    List<PillTodoParent> pillTodoParents = [];

    // 이후 데이터 가공
    for (var eTakingTime in ETakingTime.values
        .where((element) => element != ETakingTime.INVISIBLE)) {
      List<dynamic> scheduleJson =
          response['schedule'][eTakingTime.toString().split(".").last];
      List<PillTodoChildren> pillTodoChildrenList = scheduleJson
          .map((json) => PillTodoChildren.fromJson(
                json,
                base64ImageMap,
              ))
          .toList();

      if (pillTodoChildrenList.isEmpty) {
        continue;
      }

      pillTodoParents.add(
        PillTodoParent(
          eTakingTime: eTakingTime,
          isCompleted: pillTodoChildrenList.every((element) => element.isTaken),
          isExpanded: false,
          isOverLap: overlapResult[eTakingTime.toString().split(".").last]
                  ?.isNotEmpty ??
              false,
          todos: pillTodoChildrenList,
          overlapInfo:
              overlapResult[eTakingTime.toString().split(".").last] ?? [],
        ),
      );
    }

    return pillTodoParents;
  }

  Future<bool> updatePillTodoParent(
      DateTime dateTime, ETakingTime takingTime, bool isTaken) async {
    return await _pillTodoProvider.updatePillTodoParent(
        dateTime, takingTime, isTaken);
  }

  Future<bool> updatePillTodoChildren(int doseId, bool isTaken) async {
    return await _pillTodoProvider.updatePillTodoChildren(doseId, isTaken);
  }

  Future<bool> getIsDetail() async {
    return await _pillTodoProvider.readUserIsDetail();
  }
}
