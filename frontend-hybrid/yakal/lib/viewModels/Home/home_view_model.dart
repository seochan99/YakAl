import 'package:get/get.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/home_info_model.dart';

class HomeViewModel extends GetxController {
  late final RxBool _isExpanded = false.obs;
  late final Rx<HomeInfoModel> _homeInfoModel;
  late final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();

  bool get isExpanded => _isExpanded.value;
  HomeInfoModel get homeInfoModel => _homeInfoModel.value;
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();

  HomeViewModel() {
    _isExpanded.value = false;

    _pillTodoParents
        .addAll(PillTodoParent.getDummies().map((e) => e.obs).toList());

    _homeInfoModel = HomeInfoModel(
        date: DateTime.now(),
        // pilltodoParent의 pillCount를 다 더해야함
        totalCount: _pillTodoParents
            .map((e) => e.value.todos.length)
            .reduce((value, element) => value + element),
        // todos의 isTaken이 true인 것의 개수 / 총 todos의 개수
        takenCount: _pillTodoParents
            .map((e) => e.value.todos
                .where((element) => element.isTaken == true)
                .length)
            .reduce((value, element) => value + element)).obs;
  }

  void onClickParentCheckBox(ETakingTime eTakingTime) {
    // _pillTodoParents에서 eTakingTime에 해당하는 PillTodoParent를 찾고
    // 그 안의 todos의 isTaken을 PillTodoParent의 isCompleted로 변경
    _pillTodoParents.value = _pillTodoParents.map((parent) {
      if (parent.value.eTakingTime == eTakingTime) {
        parent.value.isCompleted = !parent.value.isCompleted;
        for (var children in parent.value.todos) {
          children.isTaken = parent.value.isCompleted;
        }
      }
      return parent;
    }).toList();

    // homeTopModel의 takenCount를 업데이트
    _homeInfoModel.update((val) {
      val!.takenCount = _pillTodoParents
          .map((e) =>
              e.value.todos.where((element) => element.isTaken == true).length)
          .reduce((value, element) => value + element);
    });
  }

  void onClickParentItemView(ETakingTime eTakingTime) {
    // _pillTodoParents에서 eTakingTime에 해당하는 PillTodoParent를 찾고
    // 그 안의 isExpanded를 변경
    _pillTodoParents.value = _pillTodoParents.map((parent) {
      if (parent.value.eTakingTime == eTakingTime) {
        parent.value.isExpanded = !parent.value.isExpanded;
      }
      return parent;
    }).toList();
  }

  void onClickChildrenCheckBox(ETakingTime eTakingTime, int todoId) {
    // _pillTodoParents에서 eTakingTime에 해당하는 PillTodoParent를 찾고
    // 그 안의 todos에서 todoId에 해당하는 PillTodo를 찾고
    // 그 안의 isTaken을 변경
    _pillTodoParents.value = _pillTodoParents.map((parent) {
      if (parent.value.eTakingTime == eTakingTime) {
        parent.value.todos = parent.value.todos.map((todo) {
          if (todo.id == todoId) {
            todo.isTaken = !todo.isTaken;
          }
          return todo;
        }).toList();
      }
      return parent;
    }).toList();

    // homeTopModel의 takenCount를 업데이트
    _homeInfoModel.update((val) {
      val!.takenCount = _pillTodoParents
          .map((e) =>
              e.value.todos.where((element) => element.isTaken == true).length)
          .reduce((value, element) => value + element);
    });

    // _pillTodoParents에서 eTakingTime에 해당하는 PillTodoParent를 찾고
    // 그 안의 todos에서 isTaken이 모두 true라면 PillTodoParent의 isCompleted를 true로 변경
    _pillTodoParents.value = _pillTodoParents.map((parent) {
      if (parent.value.eTakingTime == eTakingTime) {
        parent.value.isCompleted = parent.value.todos
            .where((element) => element.isTaken == false)
            .isEmpty;
      }
      return parent;
    }).toList();
  }

  void onClickPillAddButton() {
    _isExpanded.value = !_isExpanded.value;
  }
}
