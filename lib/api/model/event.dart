import 'package:flutter/material.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/model/time_range.dart';
part 'event.jser.dart';

@GenSerializer()
class EventSerializer extends Serializer<Event> with _$EventSerializer {}

class Event extends TimeRange {
  String lesson;
  String room;
  String type;
  String raw;

  Event({DateTime timeStart, DateTime timeEnd}) : super(timeStart, timeEnd);

  Color getColor() {
    switch (type) {
      case 'Лк':
        {
          return Colors.yellowAccent;
        }
      case 'Пз':
        {
          return Colors.greenAccent;
        }
      case 'Лб':
        {
          return Colors.pinkAccent;
        }
    }
  }

  @override
  String toString() {
    return '$lesson $room $type ${timeStartString()} - ${timeEndString()}';
  }
}
