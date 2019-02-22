import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nure_schedule/widgets/day_pager_controller.dart';

typedef Widget DayBuilder(DateTime day);

class DayPager extends StatefulWidget {
  final DayBuilder builder;
  final DayPagerController pagerController;

  DayPager({
    DayPagerController pagerController,
    @required this.builder,
  }) : pagerController = pagerController ?? DayPagerController();

  @override
  State<StatefulWidget> createState() => _DayPagerState();
}

class _DayPagerState extends State<DayPager> {
  DayPagerController get dayPagerController => widget.pagerController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dayPagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dayPagerController.calculateInitialOffset(context);

    return SafeArea(child: buildListView());
  }

  Widget buildListView() {
    double dayWidth = dayPagerController.calculateDayWidth(context);
    return ListView.builder(
      controller: dayPagerController.scrollController,
      itemExtent: dayWidth,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, daysFromMinDate) {
        print(daysFromMinDate);
        DateTime day = dayPagerController.getDate(daysFromMinDate);

        return SizedBox(
          width: dayWidth,
          child: widget.builder(day),
        );
      },
      addRepaintBoundaries: false,
      addAutomaticKeepAlives: false,
    );
  }
}
