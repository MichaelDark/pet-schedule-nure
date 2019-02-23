import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/model/time_range.dart';
import 'package:nure_schedule/util/date_utils.dart';
part 'group_events.jser.dart';

@GenSerializer()
class GroupEventsSerializer extends Serializer<GroupEvents> with _$GroupEventsSerializer {}

class GroupEvents {
  Group group;
  List<Event> events = [];

  GroupEvents({this.group});

  List<Event> getEvents(DateTime date) => events.where((Event event) => correspondsDate(date, event.timeStart)).toList();

  List<ITimeRange> getNurePairsRanges() {
    Map<int, ITimeRange> map = {};
    for (Event event in events) {
      map.putIfAbsent(
        event.timeId,
        () => TimeRange.copy(event),
      );
    }
    List<ITimeRange> nurePairs = map.values.toList();
    nurePairs.sort((time1, time2) => time1.timeStart.compareTo(time2.timeStart));
    return nurePairs;
  }

  @override
  String toString() => '${group.id} \r\n${events.join(" ----- ")}';
}
