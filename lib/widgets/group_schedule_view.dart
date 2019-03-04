import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/model/time_range.dart';
import 'package:nure_schedule/widgets/date_header.dart';
import 'package:nure_schedule/widgets/expanded_grid.dart';
import 'package:nure_schedule/widgets/nure_day_view.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';
import 'package:nure_schedule/widgets/schedule_view.dart';

class GroupScheduleView extends StatelessWidget {
  final Group group;
  final ScheduleController controller;

  GroupScheduleView({
    @required this.group,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Stopwatch watch = Stopwatch();
    watch.start();

    List<ITimeRange> nurePairs = group.getNurePairsRanges();
    TextStyle style = TextStyle(
      fontSize: 12,
      color: Theme.of(context).textTheme.display1.color,
    );

    var row = Row(
      children: <Widget>[
        Container(
          width: headersSize,
          child: Column(
            children: <Widget>[
              DateHeader.leftTopCorner(),
              Divider(height: 5),
              Expanded(
                child: nurePairs.isNotEmpty
                    ? ExpandedGrid(
                        itemCount: nurePairs.length,
                        itemBuilder: (BuildContext context, int index, _, __) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(nurePairs[index].timeStartString(), style: style),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(nurePairs[index].timeEndString(), style: style),
                              ),
                            ],
                          );
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ScheduleView(
            controller: controller,
            builder: (DateTime day) {
              return NureDayView(
                day: day,
                group: group,
                onHeaderClick: () => controller.jumpTo(day),
              );
            },
          ),
        ),
      ],
    );

    watch.stop();
    log('GroupScheduleView', 'build', '${watch.elapsed}');
    return row;
  }
}
