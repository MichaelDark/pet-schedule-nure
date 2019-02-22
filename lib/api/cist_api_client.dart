import 'package:csv/csv.dart';
import 'package:meta/meta.dart';
import 'package:nure_schedule/api/cist_url_builder.dart';
import 'package:nure_schedule/api/enum/cist_url.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/event_list.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/api/util/cp1251.dart';
import 'package:http/http.dart' as http;
import 'package:nure_schedule/api/util/date_utils.dart';

class CistApiClient {
  CistApiClient._();
  static Future<EventList> getGroupEvents({
    @required Group group,
    @required DateTime dateStart,
    @required DateTime dateEnd,
  }) async {
    CistUrlBuilder urlBuilder = CistUrlBuilder.csv(CistUrl.group);
    urlBuilder.addGroups([group]);
    urlBuilder.addDateStart(dateStart);
    urlBuilder.addDateEnd(dateEnd);

    http.Response response = await http.get(urlBuilder.url);
    print(urlBuilder.url);
    String responseBody = decodeCp1251(response.bodyBytes);

    EventList eventList = EventListParser().parseCsv(group.id, responseBody);
    return eventList;
  }
}

class EventListParser {
  static final EventListParser _instance = EventListParser._();
  EventListParser._();
  factory EventListParser() => _instance;

  EventList parseCsv(int groupId, String csv) {
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
        Event parsedEvent = Event()
          ..raw = rawEvent[0]
          ..lesson = eventDescription[isManyGroups ? 2 : 0]
          ..type = eventDescription[isManyGroups ? 3 : 1]
          ..room = eventDescription[isManyGroups ? 4 : 2]
          ..datetimeStart = parseDate(rawEvent[1], rawEvent[2])
          ..datetimeEnd = parseDate(rawEvent[3], rawEvent[4]);
        eventList.events.add(parsedEvent);
      } catch (exception) {
        print(exception);
      }
    }
    return eventList;
  }
}
