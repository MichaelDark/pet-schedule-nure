import 'package:csv/csv.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/util/date_utils.dart';

class GroupEventsParser {
  static final GroupEventsParser _instance = GroupEventsParser._();
  GroupEventsParser._();
  factory GroupEventsParser() => _instance;

  Group parseCsv(Group targetGroup, String csv) {
    bool isManyGroups = false; //todo add support

    Group resultGroup = Group.copyMeta(targetGroup);
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
        List<String> rawEventDescriptions = rawEvent[0].split(';');
        for (int i = 0; i < rawEventDescriptions.length; i += 2) {
          List<String> eventDescription = rawEventDescriptions[i].trim().split(' ');

          // print(eventDescription[isManyGroups ? 2 : 0]);
          // print(eventDescription[isManyGroups ? 2 : 0]);
          // print('\r\n');
          if (eventDescription.length > 1) {
            Event parsedEvent = Event()
              ..groupId = targetGroup.id
              ..lesson = eventDescription[isManyGroups ? 2 : 0]
              ..type = eventDescription[isManyGroups ? 3 : 1]
              ..room = eventDescription[isManyGroups ? 4 : 2]
              ..timeStart = parseDate(rawEvent[1], rawEvent[2])
              ..timeEnd = parseDate(rawEvent[3], rawEvent[4])
              ..raw = rawEventDescriptions[i];
            resultGroup.events.add(parsedEvent);
          }
        }
      } catch (exception) {
        print(exception);
      }
    }
    return resultGroup;
  }
}
