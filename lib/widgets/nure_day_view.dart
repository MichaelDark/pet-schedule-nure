import 'package:flutter/material.dart';
import 'package:nure_schedule/api/enum/nure_pair.dart';
import 'package:nure_schedule/api/model/event.dart';

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

    return Column(
      children: eventsList.map((event) => _buildEvent(event)).toList(),
    );
  }

  Widget _buildEvent(List<Event> events) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: events.length,
        primary: false,
        itemBuilder: (context, index) {
          Event event = events[index];
          return Container(
            color: event?.color ?? null,
            child: Text(event?.toString() ?? ''),
          );
        },
      ),
    );
  }
}
