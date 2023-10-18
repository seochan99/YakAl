import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_parent.dart';

class PillTodoViewModel {
  final RxBool _isLoaded = false.obs;
  final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();

  bool get isLoaded => _isLoaded.value;
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();

  void updatePillTodoAndDate() {}
  void onClickParentCheckBox(ETakingTime eTakingTime) {}
  void onClickParentItemView(ETakingTime eTakingTime) {}
  void onClickChildrenCheckBox(ETakingTime eTakingTime, int todoId) {}
}
