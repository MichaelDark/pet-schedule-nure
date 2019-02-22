import 'package:csv/csv.dart';
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

  factory EventList.fromCsv(int groupId, String csv) => _parseCsv(groupId, csv);

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

  static EventList _parseCsv(int groupId, String csv) {
    bool isManyGroups = false; //todo add support

    EventList eventList = EventList.withId(groupId);
    List<List<dynamic>> rawEvents = CsvToListConverter().convert(csv, eol: '\r', fieldDelimiter: ',')..removeAt(0);

    for (List<dynamic> rawEvent in rawEvents) {
      try {
        ///[eventDescription]
        /// `0`  - Тема (Group_Name - Lesson Type Room...)
        /// `1`  - Дата начала
        /// `2`  - Время начала
        /// `3`  - Дата завершения
        /// `4`  - Время завершения
        /// `5`  - Ежедневное событие
        /// `6`  - Оповещение вкл / выкл
        /// `7`  - Дата оповещения
        /// `8`  - Время оповещения
        /// `9`  - В это время
        /// `10` - Важность
        /// `11` - Описание
        /// `12` - Пометка
        List<String> eventDescription = rawEvent[0].split(' ');
        // print(rawEvent[0]);
        // print(rawEvent[0].split(' '));
        // print(rawEvent[0].split(';'));
        // print('\r\n');
        List<String> events = rawEvent[0].split(';');
        for (String event in events) {
          if (event.contains(RegExp(r'[.*\sЛк.\s*][.*\sПз.\s*][.*\sЛб.\s*]'))) {
            Event parsedEvent = Event()
              ..raw = rawEvent[0]
              ..lesson = eventDescription[isManyGroups ? 2 : 0]
              ..type = eventDescription[isManyGroups ? 3 : 1]
              ..room = eventDescription[isManyGroups ? 4 : 2]
              ..datetimeStart = parseDate(rawEvent[1], rawEvent[2])
              ..datetimeEnd = parseDate(rawEvent[3], rawEvent[4]);
            eventList.events.add(parsedEvent);
          }
        }
      } catch (exception) {
        print(exception);
      }
    }
    return eventList;
  }

  @override
  String toString() => '$id \r\n${events.join(" ----- ")}';
}
