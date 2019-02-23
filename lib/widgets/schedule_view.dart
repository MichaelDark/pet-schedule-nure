import 'package:flutter/material.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';

typedef Widget DayBuilder(DateTime day);

class ScheduleView extends StatefulWidget {
  final DayBuilder builder;
  final ScheduleController controller;

  ScheduleView({
    @required this.builder,
    ScheduleController pagerController,
  }) : controller = pagerController ?? ScheduleController();

  @override
  State<StatefulWidget> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  ScheduleController get dayPagerController => widget.controller;

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
