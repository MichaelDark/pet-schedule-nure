import 'package:flutter/material.dart';
import 'package:nure_schedule/api/enum/nure_pair.dart';
import 'package:nure_schedule/api/model/event.dart';

class NureDay extends StatelessWidget {
  final DateTime date;
  final List<Event> events;

  NureDay({
    @required this.date,
    @required this.events,
  });

  num get heightFactor => 1 / NurePair.values.length;

  @override
  Widget build(BuildContext context) {
    List<Event> eventsList = List.generate(NurePair.values.length, (int index) => null);

    for (Event event in events) {
      NurePair pair = NurePair.getByTime(event);
      if (pair != null) {
        eventsList.removeAt(pair.id);
        eventsList.insert(pair.id, event);
      }
    }

    return Column(
      children: eventsList.map((event) => _buildEvent(event)).toList(),
    );
  }

  Widget _buildEvent(Event event) {
    return Container(
      color: event?.color ?? null,
      child: SizedBox(
        height: 50,
        child: Text(event?.toString() ?? ''),
      ),
    );
  }
}
