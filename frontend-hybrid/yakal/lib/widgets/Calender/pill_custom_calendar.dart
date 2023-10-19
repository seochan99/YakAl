import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yakal/viewModels/Calendar/calendar_viewmodel.dart';

class CustomPillCalendar extends StatefulWidget {
  final CalendarViewModel viewModel;

  CustomPillCalendar({required this.viewModel, Key? key}) : super(key: key);

  @override
  State<CustomPillCalendar> createState() =>
      _CustomPillCalendarState(viewModel: viewModel);
}

class _CustomPillCalendarState extends State<CustomPillCalendar> {
  final CalendarViewModel viewModel;

  _CustomPillCalendarState({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(
                viewModel.calendarDate.focusedDate.year.toString() +
                    '년 ' +
                    viewModel.calendarDate.focusedDate.month.toString() +
                    '월',
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
