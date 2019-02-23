import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:nure_schedule/model/time_range.dart';
import 'package:nure_schedule/widgets/date_header.dart';
import 'package:nure_schedule/widgets/day_event.dart';
import 'package:nure_schedule/widgets/expanded_grid.dart';

class NureDayView extends StatelessWidget {
  final DateTime day;
  final List<List<Event>> _rangeEvents = [];
  final void Function() onHeaderClick;

  NureDayView({
    @required this.day,
    @required GroupEvents groupEvents,
    this.onHeaderClick,
  }) {
    Map<int, List<Event>> eventsMap = {};
    List<Event> events = List.from(groupEvents.getEvents(day));
    List<ITimeRange> ranges = List.from(groupEvents.getNurePairsRanges());

    ranges.sort((range, checkRange) => range.timeId.compareTo(checkRange.timeId));
    ranges.forEach((ITimeRange range) => eventsMap[range.timeId] = []);

    for (Event event in events) {
      if (eventsMap[event.timeId] != null) {
        eventsMap[event.timeId].add(event);
      }
    }

    List<int> timeIdKeys = eventsMap.keys.toList();
    timeIdKeys.sort();
    timeIdKeys.forEach((int timeIdKey) => _rangeEvents.add(eventsMap[timeIdKey]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onHeaderClick == null ? () {} : onHeaderClick,
          child: DateHeader(day: day),
        ),
        Divider(height: 5),
        Expanded(
          child: ExpandedGrid(
            itemCount: _rangeEvents.length,
            itemBuilder: (context, index, _, itemHeight) {
              List<Event> currentEvents = _rangeEvents[index];
              return SizedBox(
                height: itemHeight,
                child: currentEvents.isNotEmpty ? DayEvent(events: currentEvents) : Container(),
              );
            },
          ),
        ),
      ],
    );
  }
}
