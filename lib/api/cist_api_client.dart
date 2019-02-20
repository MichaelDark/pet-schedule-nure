import 'package:meta/meta.dart';
import 'package:nure_schedule/api/cist_url_builder.dart';
import 'package:nure_schedule/api/enum/cist_url.dart';
import 'package:nure_schedule/api/model/event_list.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/api/util/cp1251.dart';
import 'package:http/http.dart' as http;

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
    String responseBody = decodeCp1251(response.bodyBytes);

    EventList eventList = EventList.fromCsv(group.id, responseBody);
    return eventList;
  }
}
