import 'package:flutter/material.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'event.jser.dart';

@GenSerializer()
class EventSerializer extends Serializer<Event> with _$EventSerializer {}

class Event {
  String lesson;
  String room;
  String type;
  DateTime datetimeStart;
  DateTime datetimeEnd;

  Color get color {
    switch (type) {
      case 'Лк':
        {
          return Colors.yellowAccent;
        }
      case 'Пз':
        {
          return Colors.greenAccent;
        }
      case 'Лр':
        {
          return Colors.pinkAccent;
        }
    }
  }

  @override
  String toString() {
    return '$lesson $room $type ${datetimeStart.hour}:${datetimeStart.minute} - ${datetimeEnd.hour}:${datetimeEnd.minute}';
  }
}
