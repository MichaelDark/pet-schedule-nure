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
    List<List<Event>> eventsList = List.generate(
      NurePair.values.length,
      (int index) => [],
    );

    for (Event event in events) {
      NurePair pair = NurePair.getByTime(event);
      if (pair != null) {
        eventsList[pair.id].add(event);
      }
    }
    return Column(children: <Widget>[
      buildDayHeader(date),
      Column(
        children: eventsList.map((event) => _buildEvent(event)).toList(),
      ),
    ]);
  }

  Widget buildDayHeader(DateTime day) {
    bool isToday = correspondsDate(day, DateTime.now());
    TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: isToday ? Color(0xff222222) : Color(0xff777777),
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

  Widget _buildEvent(List<Event> events) {
    Event event = events.isNotEmpty ? events.first : null;
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: event?.color ?? null,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(event?.lesson ?? ''),
                    Text(event?.type ?? ''),
                    Text(event?.timeRangeString ?? ''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
