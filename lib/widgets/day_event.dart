import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/event.dart';

class DayEvent extends StatelessWidget {
  final List<Event> events;

  DayEvent({@required this.events});

  @override
  Widget build(BuildContext context) {
    return events.length == 1 ? _buildEvent(context, event: events.first) : _buildEventList();
  }

  Widget _buildEventList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double boxWidth = constraints.maxWidth;
        double itemWidth = boxWidth - boxWidth / 10;

        return ListView.builder(
          itemCount: events.length,
          itemExtent: itemWidth,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Event event = events[index];
            return _buildEvent(context, width: itemWidth, event: event);
          },
        );
      },
    );
  }

  Widget _buildEvent(BuildContext context, {double width, Event event}) {
    String timeFrom = event.timeStartString();
    String timeTo = event.timeEndString();
    TextStyle style = TextStyle(
      color: Theme.of(context).textTheme.body1.color,
    );

    return Container(
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
                  Text(event.lesson, style: style),
                  Text(event.type, style: style),
                  Text(event.room, style: style),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
