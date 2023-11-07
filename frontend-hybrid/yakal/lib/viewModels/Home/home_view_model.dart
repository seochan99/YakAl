import 'package:get/get.dart';
import 'package:yakal/models/Calendar/count_model.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/repository/Home/pill_todo_repository.dart';

import '../../models/Home/e_taking_time.dart';
import '../../provider/Home/pill_todo_provider.dart';
import '../Base/pill_todo_viewmodel.dart';

class HomeViewModel extends GetxController implements PillTodoViewModel {
  final PillTodoRepository _pillTodoRepository =
      PillTodoRepository(pillTodoProvider: PillTodoProvider());

  late final bool _isDetail;
  final RxBool _isExpanded = false.obs;
  late final Rx<DateTime> _todoDate = DateTime.now().obs;
  final Rx<CountModel> _countModel =
      CountModel(totalCount: 0, takenCount: 0).obs;
  final RxBool _isLoaded = false.obs;
  final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();

  bool get isExpanded => _isExpanded.value;

  @override
  bool get isDetail => _isDetail;

  @override
  DateTime get todoDate => _todoDate.value;

  @override
  CountModel get countModel => _countModel.value;

  @override
  bool get isLoaded => _isLoaded.value;

  @override
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updatePillTodoAndDate();
    fetchIsDetail();
  }

  @override
  void updatePillTodoAndDate() {
    // Start Data Loading
    _isLoaded.value = true;
    _countModel.value = CountModel(totalCount: 0, takenCount: 0);

    // PillTodoParents Update
    _todoDate.value = DateTime.now();

    // Read PillTodoParents In Remote DB
    _pillTodoRepository
        .readPillTodoParents(_todoDate.value)
        // Finish Reading PillTodoParents In Remote DB
        .then((value) => {
              _pillTodoParents.value = value.map((e) => e.obs).toList(),
            })
        // Update HomeInfoModel
        .then((value) => {
              if (_pillTodoParents.isNotEmpty)
                {
                  _countModel.value = CountModel(
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
              else
                {_countModel.value = CountModel(totalCount: 0, takenCount: 0)}
            })
        // Finish Data Loading
        .then((value) => _isLoaded.value = false);
  }

  @override
  void onClickParentCheckBox(ETakingTime eTakingTime) {
    bool isCompleted = _pillTodoParents
        .firstWhere((element) => element.value.eTakingTime == eTakingTime)
        .value
        .isCompleted;

    _pillTodoRepository
        .updatePillTodoParent(_todoDate.value, eTakingTime, !isCompleted)
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
              _countModel.update((val) {
                val!.takenCount = _pillTodoParents
                    .map((e) => e.value.todos
                        .where((element) => element.isTaken == true)
                        .length)
                    .reduce((value, element) => value + element);
              })
            });
  }

  // 상태 변화
  @override
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

  @override
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
            _countModel.update((val) {
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

  void onClickOutOfPillAddMenu() {
    _isExpanded.value = false;
  }

  void fetchIsDetail() {
    _pillTodoRepository.getIsDetail().then((value) => _isDetail = value);
  }
}
