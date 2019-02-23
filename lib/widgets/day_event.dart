import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/event.dart';

class DayEvent extends StatelessWidget {
  final List<Event> events;

  DayEvent({@required this.events});

  @override
  Widget build(BuildContext context) {
    return events.length == 1 ? _buildEvent(event: events.first) : _buildEventList();
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
            return _buildEvent(width: itemWidth, event: event);
          },
        );
      },
    );
  }

  Widget _buildEvent({double width, Event event}) {
    String timeFrom = event.timeStartString();
    String timeTo = event.timeEndString();

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
                  Text(event.lesson),
                  Text(event.type),
                  Text('$timeFrom - $timeTo'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
