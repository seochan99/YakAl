import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PillCalenderDayItem extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  const PillCalenderDayItem(
      {Key? key, required this.date, required this.isSelected})
      : super(key: key);

  @override
  State<PillCalenderDayItem> createState() => _PillCalenderDayItemState();
}

class _PillCalenderDayItemState extends State<PillCalenderDayItem> {
  int _progress = 0;
  final bool isOverlap = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: CircularPercentIndicator(
              percent: _progress / 100,
              radius: 18,
              lineWidth: 2,
              // animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF2666F6),
              backgroundColor: const Color(0xFFF1F5FE),
              center: Stack(
                children: [
                  // 완료 됐을 때 보일 원
                  if (_progress == 100)
                    Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5FE),
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (widget.isSelected)
                    Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF5588FD),
                        shape: BoxShape.circle,
                      ),
                    ),
                  Center(
                    child: Text(
                      widget.date.day.toString(),
                      style: widget.isSelected
                          ? const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)
                          : const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox.fromSize(size: const Size.fromHeight(5)),
          SvgPicture.asset(
            'assets/icons/icon-overlap.svg',
            width: 36,
          )
        ],
      ),
    );
  }
}