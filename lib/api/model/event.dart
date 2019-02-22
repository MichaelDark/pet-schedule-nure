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
  String raw;

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
      case 'Лб':
        {
          return Colors.pinkAccent;
        }
    }
  }

  String get timeRangeString => ' ${datetimeStart.hour}:${datetimeStart.minute} - ${datetimeEnd.hour}:${datetimeEnd.minute}';

  @override
  String toString() {
    return '$lesson $room $type $timeRangeString';
  }
}
