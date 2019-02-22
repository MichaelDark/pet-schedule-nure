import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/util/date_utils.dart';
part 'event_list.jser.dart';

@GenSerializer()
class EventListSerializer extends Serializer<EventList> with _$EventListSerializer {}

class EventList {
  int id;
  List<Event> events = [];

  EventList();
  EventList.withId(this.id);

  List<Event> getEvents(DateTime date) => events.where((Event event) => correspondsDate(date, event.datetimeStart)).toList();
  DateTime get minDate {
    DateTime currentMinDate;
    events.forEach((Event event) {
      if (currentMinDate == null || event.datetimeStart.isBefore(currentMinDate)) {
        currentMinDate = event.datetimeStart;
      }
    });
    return currentMinDate;
  }

  @override
  String toString() => '$id \r\n${events.join(" ----- ")}';
}
