import 'package:yakal/models/Home/pill_todo_children.dart';
import 'e_taking_time.dart';
import 'overlap_info.dart';

class PillTodoParent {
  final ETakingTime eTakingTime;
  bool isCompleted;
  bool isExpanded;
  bool isOverLap;
  List<PillTodoChildren> todos;
  List<OverlapInfo> overlapInfo;

  PillTodoParent({
    required this.eTakingTime,
    required this.isCompleted,
    required this.isExpanded,
    required this.isOverLap,
    required this.todos,
    required this.overlapInfo,
  });

  factory PillTodoParent.getInvisibleSchedule() {
    return PillTodoParent(
      eTakingTime: ETakingTime.INVISIBLE,
      isCompleted: false,
      isExpanded: false,
      isOverLap: false,
      todos: [],
      overlapInfo: [],
    );
  }

  String getTotalCnt() {
    return "${todos.length.toString()}개";
  }

  @override
  String toString() {
    // TODO: implement toString
    return "PillTodoParent: ${eTakingTime.time}, ${todos.length.toString()}개";
  }
}
