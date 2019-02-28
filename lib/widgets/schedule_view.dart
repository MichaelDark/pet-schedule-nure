import 'package:flutter/material.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';

typedef Widget DayBuilder(DateTime day);

class ScheduleView extends StatefulWidget {
  final DayBuilder builder;
  final ScheduleController controller;

  ScheduleView({@required this.builder, @required this.controller});

  @override
  State<StatefulWidget> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  ScheduleController get controller => widget.controller;

  @override
  void dispose() {
    if (controller != null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(child: buildListView());

  Widget buildListView() {
    controller.calculateInitialOffset();

    double dayWidth = controller.calculateDayWidth();

    return ListView.builder(
      controller: controller.scrollController,
      itemExtent: dayWidth,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, daysFromMinDate) {
        print(daysFromMinDate);
        DateTime day = controller.getDate(daysFromMinDate);

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
