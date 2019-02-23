import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group/group.dart';
import 'package:nure_schedule/api/util/date_utils.dart';
part 'group_events.jser.dart';

@GenSerializer()
class GroupEventsSerializer extends Serializer<GroupEvents> with _$GroupEventsSerializer {}

class GroupEvents {
  Group group;
  List<Event> events = [];

  GroupEvents({this.group});

  List<Event> getEvents(DateTime date) => events.where((Event event) => correspondsDate(date, event.timeStart)).toList();

  int calculateEventsPerDay() {
    Map<String, int> map = {};
    for (Event event in events) {
      map.putIfAbsent(
        '${event.timeStart.hour}:${event.timeStart.minute}',
        () => 0,
      );
    }
    return map.keys.length;
  }

  DateTime calculateMinDate() {
    DateTime currentMinDate;
    events.forEach((Event event) {
      if (currentMinDate == null || event.timeStart.isBefore(currentMinDate)) {
        currentMinDate = event.timeStart;
      }
    });
    return currentMinDate;
  }

  @override
  String toString() => '${group.id} \r\n${events.join(" ----- ")}';
}
