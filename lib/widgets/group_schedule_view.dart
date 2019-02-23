import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:nure_schedule/model/time_range.dart';
import 'package:nure_schedule/widgets/date_header.dart';
import 'package:nure_schedule/widgets/expanded_grid.dart';
import 'package:nure_schedule/widgets/nure_day_view.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';
import 'package:nure_schedule/widgets/schedule_view.dart';

class GroupScheduleView extends StatelessWidget {
  final GroupEvents groupEvents;
  final ScheduleController controller;

  GroupScheduleView({
    @required this.groupEvents,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<ITimeRange> nurePairs = groupEvents.getNurePairsRanges();

    return Row(
      children: <Widget>[
        Container(
          width: headersSize,
          child: Column(
            children: <Widget>[
              DateHeader.leftTopCorner(),
              Divider(height: 5),
              Expanded(
                child: ExpandedGrid(
                  itemCount: nurePairs.length,
                  itemBuilder: (BuildContext context, int index, _, __) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(nurePairs[index].timeStartString(), style: Theme.of(context).textTheme.body2),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(nurePairs[index].timeEndString(), style: Theme.of(context).textTheme.body2),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ScheduleView(
            pagerController: controller,
            builder: (DateTime day) {
              return NureDayView(
                day: day,
                groupEvents: groupEvents,
                onHeaderClick: () => controller.jumpTo(context, day),
              );
            },
          ),
        ),
      ],
    );
  }
}
