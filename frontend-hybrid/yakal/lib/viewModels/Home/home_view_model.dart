import 'package:get/get.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/repository/Home/pill_todo_repository.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/home_info_model.dart';
import '../../provider/Home/pill_todo_provider.dart';

class HomeViewModel extends GetxController {
  final PillTodoRepository _pillTodoRepository =
      PillTodoRepository(pillTodoProvider: PillTodoProvider());

  final RxBool _isExpanded = false.obs;
  final RxBool _isLoaded = false.obs;
  final Rx<HomeInfoModel> _homeInfoModel =
      HomeInfoModel(date: DateTime.now(), totalCount: 0, takenCount: 0).obs;
  final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();

  bool get isExpanded => _isExpanded.value;
  bool get isLoaded => _isLoaded.value;
  HomeInfoModel get homeInfoModel => _homeInfoModel.value;
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();

  HomeViewModel() {
    _isExpanded.value = false;
    updatePillTodoAndDate();
  }

  void updatePillTodoAndDate() {
    // Start Data Loading
    _isLoaded.value = true;

    // PillTodoParents Update
    DateTime date = DateTime.now();

    // Read PillTodoParents In Remote DB
    _pillTodoRepository
        .readPillTodoParents(date)
        // Finish Reading PillTodoParents In Remote DB
        .then((value) => {
              _pillTodoParents.value = value.map((e) => e.obs).toList(),
            })
        // Update HomeInfoModel
        .then((value) => {
              if (_pillTodoParents.isNotEmpty)
                {
                  _homeInfoModel.value = HomeInfoModel(
                      date: date,
                      // pilltodoParent의 pillCount를 다 더해야함
                      totalCount: _pillTodoParents
                          .map((e) => e.value.todos.length)
                          .reduce((value, element) => value + element),
                      // todos의 isTaken이 true인 것의 개수 / 총 todos의 개수
                      takenCount: _pillTodoParents
                          .map((e) => e.value.todos
                              .where((element) => element.isTaken == true)
                              .length)
                          .reduce((value, element) => value + element))
                }
            })
        // Finish Data Loading
        .then((value) => _isLoaded.value = false);
  }

  void onClickParentCheckBox(ETakingTime eTakingTime) {
    bool isCompleted = _pillTodoParents
        .firstWhere((element) => element.value.eTakingTime == eTakingTime)
        .value
        .isCompleted;

    _pillTodoRepository
        .updatePillTodoParent(
            _homeInfoModel.value.date, eTakingTime, !isCompleted)
        .then((value) => {
              if (value)
                _pillTodoParents.value = _pillTodoParents.map((parent) {
                  if (parent.value.eTakingTime == eTakingTime) {
                    parent.value.isCompleted = !parent.value.isCompleted;
                    for (var children in parent.value.todos) {
                      children.isTaken = parent.value.isCompleted;
                    }
                  }
                  return parent;
                }).toList()
              else
                print("Failed to update PillTodoParents")
            })
        .then((value) => {
              // homeTopModel의 takenCount를 업데이트
              _homeInfoModel.update((val) {
                val!.takenCount = _pillTodoParents
                    .map((e) => e.value.todos
                        .where((element) => element.isTaken == true)
                        .length)
                    .reduce((value, element) => value + element);
              })
            });
  }

  // 상태 변화
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
    // 그 안의 isTaken 값 들고오기

    bool isTaken = _pillTodoParents
        .firstWhere((element) => element.value.eTakingTime == eTakingTime)
        .value
        .todos
        .firstWhere((element) => element.id == todoId)
        .isTaken;

    _pillTodoRepository
        .updatePillTodoChildren(todoId, !isTaken)
        .then((value) => {
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
              }).toList()
            })
        .then((value) => {
              // _pillTodoParents에서 eTakingTime에 해당하는 PillTodoParent를 찾고
              // 그 안의 todos에서 isTaken이 모두 true라면 PillTodoParent의 isCompleted를 true로 변경
              _pillTodoParents.value = _pillTodoParents.map((parent) {
                if (parent.value.eTakingTime == eTakingTime) {
                  parent.value.isCompleted = parent.value.todos
                      .where((element) => element.isTaken == false)
                      .isEmpty;
                }
                return parent;
              }).toList()
            })
        .then((value) =>
            // homeTopModel의 takenCount를 업데이트
            _homeInfoModel.update((val) {
              val!.takenCount = _pillTodoParents
                  .map((e) => e.value.todos
                      .where((element) => element.isTaken == true)
                      .length)
                  .reduce((value, element) => value + element);
            }));
  }

  void onClickPillAddButton() {
    _isExpanded.value = !_isExpanded.value;
  }
}
