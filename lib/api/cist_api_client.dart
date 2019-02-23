import 'package:meta/meta.dart';
import 'package:nure_schedule/api/cist_url_builder.dart';
import 'package:nure_schedule/api/enum/cist_url.dart';
import 'package:nure_schedule/api/model/group/group.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:nure_schedule/api/util/cp1251.dart';
import 'package:http/http.dart' as http;
import 'package:nure_schedule/api/util/group_events_parser.dart';
import 'package:nure_schedule/api/util/response_extractor.dart';

class CistApiClient {
  Future<GroupEvents> getGroupEvents({
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

    GroupEvents eventList = GroupEventsParser().parseCsv(group, responseBody);
    return eventList;
  }

  Future<List<Group>> getGroups() async {
    http.Response response = await http.get(CistUrl.groups);

    return ResponseExtractor.extractList<Group>(response, GroupSerializer());
  }
}
