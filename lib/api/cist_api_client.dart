import 'package:meta/meta.dart';
import 'package:nure_schedule/api/cist_url_builder.dart';
import 'package:nure_schedule/api/enum/cist_url.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:http/http.dart' as http;
import 'package:nure_schedule/api/util/group_events_parser.dart';
import 'package:nure_schedule/api/util/response_extractor.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/util/cp1251.dart';

class CistApiClient {
  Future<Group> getGroupEvents({
    @required Group targetGroup,
  }) async {
    log('CistApiClient', 'getGroupEvents', 'start');
    CistUrlBuilder urlBuilder = CistUrlBuilder.csv(CistUrl.group);
    urlBuilder.addGroups([targetGroup]);

    DateTime now = DateTime.now();
    if (DateTime.now().month <= 6) {
      urlBuilder.addDateStart(DateTime(now.year, 1, 1));
      urlBuilder.addDateEnd(DateTime(now.year, 7, 1));
    } else {
      urlBuilder.addDateStart(DateTime(now.year, 7, 1));
      urlBuilder.addDateEnd(DateTime(now.year, 12, 31));
    }

    http.Response response = await http.get(urlBuilder.url);

    log('CistApiClient', 'getGroupEvents', 'url ${urlBuilder.url}');
    String responseBody = decodeCp1251(response.bodyBytes);

    Group resultGroup = GroupEventsParser().parseCsv(targetGroup, responseBody);
    log('CistApiClient', 'getGroupEvents', 'end');
    return resultGroup;
  }

  Future<List<Group>> getGroupsList() async {
    http.Response response = await http.get(CistUrl.allGroups);

    String responseBody = decodeCp1251(response.bodyBytes);

    return ResponseExtractor.parseGroups(responseBody);
  }
}
