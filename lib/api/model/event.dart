import 'package:flutter/material.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/model/time_range.dart';

part 'event.jorm.dart';

class Event extends ITimeRange {
  @PrimaryKey(auto: true)
  int id;

  String lesson;

  String room;

  String type;

  String raw;

  DateTime timeStart;

  DateTime timeEnd;

  @BelongsTo(GroupBean)
  int groupId;

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
          return Colors.pinkAccent.shade100;
        }
      default:
        {
          return Colors.blueGrey.shade100;
        }
    }
  }

  @override
  String toString() {
    return '$lesson $room $type ${timeStartString()} - ${timeEndString()}';
  }
}

@GenBean()
class EventBean extends Bean<Event> with _EventBean {
  final GroupBean groupBean;

  EventBean(Adapter adapter)
      : groupBean = GroupBean(),
        super(adapter);

  @override
  String get tableName => 'events';
}
