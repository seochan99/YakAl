import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yakal/models/Calendar/calendar_model.dart';
import 'package:yakal/models/Home/pill_todo_parent.dart';
import 'package:yakal/provider/Home/pill_todo_provider.dart';
import 'package:yakal/repository/Calendar/calendar_repository.dart';
import 'package:yakal/repository/Home/pill_todo_repository.dart';

import '../../../models/Home/e_taking_time.dart';
import '../../models/Calendar/calendar_day.dart';
import '../../models/Calendar/count_model.dart';
import '../../models/Home/overlap_info.dart';
import '../../provider/Calendar/calendar_provider.dart';
import '../Base/pill_todo_viewmodel.dart';
import '../Home/home_view_model.dart';

class CalendarViewModel extends GetxController implements PillTodoViewModel {
  // Repository
  final PillTodoRepository _pillTodoRepository =
      PillTodoRepository(pillTodoProvider: PillTodoProvider());
  final CalendarRepository _calendarRepository =
      CalendarRepository(calendarProvider: CalendarProvider());

  // Model
  final Rx<CalendarDate> _calendarDate =
      Rx<CalendarDate>(CalendarDate.selectedDate(selectedDate: DateTime.now()));
  late final Rx<DateTime> _todoDate;
  final Rx<CountModel> _countModel =
      Rx<CountModel>(CountModel(totalCount: 0, takenCount: 0));

  final RxBool _isLoadedCalendar = false.obs;
  final RxMap<String, Rx<CalendarDay>> _calendarDays = RxMap({});

  final RxBool _isLoaded = false.obs;
  final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();

  // public getter
  CalendarDate get calendarDate => _calendarDate.value;
  @override
  DateTime get todoDate => _todoDate.value;
  @override
  CountModel get countModel => _countModel.value;

  bool get isLoadedCalendar => _isLoadedCalendar.value;
  Map<String, Rx<CalendarDay>> get calendarDays => _calendarDays;
  @override
  bool get isLoaded => _isLoaded.value;
  @override
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();

  @override
  void onInit() {
    super.onInit();

    _todoDate = Rx<DateTime>(_calendarDate.value.selectedDate);

    updateCalendarDays();
    updatePillTodoAndDate();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.find<HomeViewModel>().updatePillTodoAndDate();
    super.onClose();
  }

  void updateCalendarDays() async {
    _isLoadedCalendar.value = true;
    DateTime date = _calendarDate.value.focusedDate;
    _calendarDays.value =
        (await _calendarRepository.readCalendarInformation(date))
            .map((key, value) {
      return MapEntry(key, value.obs);
    });
    _isLoadedCalendar.value = false;
  }

  @override
  void updatePillTodoAndDate() {
    // Start Data Loading
    _isLoaded.value = true;
    _countModel.update((val) {
      val!.totalCount = 0;
      val.takenCount = 0;
    });

    // Update TodoDate
    _todoDate.value = _calendarDate.value.selectedDate;

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
        .updatePillTodoParent(
            _calendarDate.value.selectedDate, eTakingTime, !isCompleted)
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
            })
        .then((value) =>
            // selectedDate에 해당하는 Map에서 찾아 업데이트
            _calendarDays.forEach((key, value) {
              if (key ==
                  DateFormat("yyyy-MM-dd").format(calendarDate.selectedDate)) {
                print("update calendarDay $key");
                value.update((val) {
                  val!.progress = _countModel.value.getProgress();
                });
              }
            }));
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
            _countModel.update((val) {
              val!.takenCount = _pillTodoParents
                  .map((e) => e.value.todos
                      .where((element) => element.isTaken == true)
                      .length)
                  .reduce((value, element) => value + element);
            }))
        .then((value) =>
            // selectedDate에 해당하는 Map에서 찾아 업데이트
            _calendarDays.forEach((key, value) {
              if (key ==
                  DateFormat("yyyy-MM-dd").format(calendarDate.selectedDate)) {
                print("update calendarDay $key");
                value.update((val) {
                  val!.progress = _countModel.value.getProgress();
                });
              }
            }));
  }

  // calendarItem을 클릭했을 때
  Future<void> onClickCalendarItem(DateTime date) async {
    int beforeMonth = _calendarDate.value.focusedDate.month;

    // _calendarModel의 selectedDate를 date로 변경
    _calendarDate.value =
        _calendarDate.value.copyWith(selectedDate: date, focusedDate: date);

    if (beforeMonth != _calendarDate.value.focusedDate.month) {
      updateCalendarDays();
    }

    updatePillTodoAndDate();
  }

  // calendarItem을 스와이프했을 때
  Future<void> changeFocusedDate(DateTime date) async {
    int beforeMonth = _calendarDate.value.focusedDate.month;
    _calendarDate.value = _calendarDate.value.copyWith(focusedDate: date);

    if (beforeMonth != _calendarDate.value.focusedDate.month) {
      updateCalendarDays();
    }
  }
}
