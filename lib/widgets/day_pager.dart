import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef Widget DayBuilder(DateTime day);

class DayPager extends StatefulWidget {
  final DayBuilder builder;
  final int daysPerPage;
  final DateTime initialDay;
  final DateTime minDate;

  DayPager({
    @required this.builder,
    this.daysPerPage = 3,
    DateTime minDate,
    DateTime initialDay,
  })  : initialDay = initialDay ?? DateTime.now(),
        minDate = minDate ?? DateTime(2018);

  @override
  State<StatefulWidget> createState() => _DayPagerState();
}

class _DayPagerState extends State<DayPager> {
  ScrollController controller;
  int daysPerPage;
  int initialPage;

  @override
  void initState() {
    super.initState();

    this.daysPerPage = widget.daysPerPage;
    this.initialPage = getDaysFromMinDate(widget.initialDay);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dayWidth = screenWidth / daysPerPage;

    if (controller == null) {
      double initialScrollOffset = (initialPage * dayWidth).toDouble();
      this.controller = ScrollController(
        initialScrollOffset: initialScrollOffset,
      );
    }

    return SafeArea(
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, daysFromMinDate) {
          print(daysFromMinDate);
          DateTime day = getDate(daysFromMinDate);

          return SizedBox(
            width: dayWidth,
            child: Column(
              children: <Widget>[
                buildDayHeader(day),
                widget.builder(day),
              ],
            ),
          );
        },
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: false,
      ),
    );
  }

  int getDaysFromMinDate(DateTime date) => widget.minDate.difference(date).inDays.abs();
  DateTime getDate(int daysFromMinDate) => widget.minDate.add(Duration(days: daysFromMinDate));

  Widget buildDayHeader(DateTime day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(formatWeekDay(day)),
        Text(formatDate(day)),
        Text(day.year.toString()),
      ],
    );
  }

  String formatWeekDay(DateTime date) => DateFormat('EEEE').format(date);
  String formatDate(DateTime date) => DateFormat('MMM dd').format(date);
}
