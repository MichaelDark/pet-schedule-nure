import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nure_schedule/api/enum/nure_pair.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/util/date_utils.dart';

class NureDayView extends StatelessWidget {
  final DateTime date;
  final List<Event> events;

  NureDayView({
    @required this.date,
    @required this.events,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, List<Event>> dayMap = {};
    for (NurePair nurePair in NurePair.values) {
      dayMap[nurePair.timeStartString()] = [];
    }

    for (Event event in events) {
      if (dayMap[event.timeStartString()] != null) {
        dayMap[event.timeStartString()].add(event);
      }
    }

    return Column(
      children: <Widget>[
        buildDayHeader(context, date),
        Divider(),
        Expanded(
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            double boxHeight = constraints.maxHeight / NurePair.values.length;
            double boxWidth = constraints.maxWidth;

            return Column(
              children: dayMap.keys.map<Widget>((String dayMapKey) {
                List<Event> currentEvents = dayMap[dayMapKey];
                if (currentEvents.isNotEmpty) {
                  return DayEvent(
                    boxWidth: boxWidth,
                    boxHeight: boxHeight,
                    events: currentEvents,
                  );
                } else {
                  return SizedBox(height: boxHeight);
                }
              }).toList(),
            );
          }),
        ),
      ],
    );
  }

  Widget buildDayHeader(BuildContext context, DateTime day) {
    ThemeData theme = Theme.of(context);

    bool isToday = correspondsDate(day, DateTime.now());
    TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: isToday ? theme.accentTextTheme.display1.color : theme.textTheme.display1.color,
      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
    );
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(formatWeekDay(day), style: textStyle),
          Text(formatDate(day), style: textStyle),
        ],
      ),
    );
  }

  String formatWeekDay(DateTime date) => DateFormat('EEEE').format(date);
  String formatDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);
}

class DayEvent extends StatelessWidget {
  final double boxHeight;
  final double boxWidth;
  final List<Event> events;

  DayEvent({this.boxWidth, this.boxHeight, this.events});

  bool get hasNoEvents => events == null || events.isEmpty;

  @override
  Widget build(BuildContext context) {
    if (hasNoEvents) return SizedBox(height: boxHeight);

    if (events.length == 1) {
      return _buildEvent(boxWidth, boxHeight, events.first);
    }

    double itemWidth = boxWidth - boxWidth / 10;
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
        itemCount: events.length,
        itemExtent: itemWidth,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Event event = events[index];
          return _buildEvent(itemWidth, boxHeight, event);
        },
      ),
    );
  }

  Widget _buildEvent(double width, double height, Event event) {
    String timeFrom = event.timeStartString();
    String timeTo = event.timeEndString();

    return SizedBox(
      height: boxHeight,
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: event?.getColor() ?? null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(event.lesson),
                    Text(event.type),
                    Text('$timeFrom - $timeTo'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
