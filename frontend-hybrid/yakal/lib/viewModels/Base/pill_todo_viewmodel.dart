import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:yakal/models/Home/overlap_info.dart';

import '../../models/Calendar/count_model.dart';
import '../../models/Home/e_taking_time.dart';
import '../../models/Home/pill_todo_parent.dart';

class PillTodoViewModel {
  final RxBool _isLoaded = false.obs;
  final Rx<DateTime> _todoDate = DateTime.now().obs;
  final Rx<CountModel> _countModel =
      Rx<CountModel>(CountModel(totalCount: 0, takenCount: 0));
  final RxList<Rx<PillTodoParent>> _pillTodoParents = RxList.empty();
  final RxMap<String, List<OverlapInfo>> _overlapInfoMap =
      RxMap<String, List<OverlapInfo>>();

  DateTime get todoDate => _todoDate.value;
  bool get isLoaded => _isLoaded.value;
  CountModel get countModel => _countModel.value;
  List<PillTodoParent> get pillTodoParents =>
      _pillTodoParents.map((e) => e.value).toList();
  Map<String, List<OverlapInfo>> get overlapInfoMap => _overlapInfoMap;

  void updatePillTodoAndDate() {}
  void onClickParentCheckBox(ETakingTime eTakingTime) {}
  void onClickParentItemView(ETakingTime eTakingTime) {}
  void onClickChildrenCheckBox(ETakingTime eTakingTime, int todoId) {}
}
