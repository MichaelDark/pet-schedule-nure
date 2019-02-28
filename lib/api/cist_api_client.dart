import 'package:meta/meta.dart';
import 'package:nure_schedule/api/cist_url_builder.dart';
import 'package:nure_schedule/api/enum/cist_url.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:http/http.dart' as http;
import 'package:nure_schedule/api/util/group_events_parser.dart';
import 'package:nure_schedule/util/cp1251.dart';

class CistApiClient {
  Future<Group> getGroupEvents({
    @required Group targetGroup,
    @required DateTime dateStart,
    @required DateTime dateEnd,
  }) async {
    print('API CALL API CALL API CALL API CALL API CALL API CALL');
    CistUrlBuilder urlBuilder = CistUrlBuilder.csv(CistUrl.group);
    urlBuilder.addGroups([targetGroup]);
    urlBuilder.addDateStart(dateStart);
    urlBuilder.addDateEnd(dateEnd);

    http.Response response = await http.get(urlBuilder.url);
    print(urlBuilder.url);
    String responseBody = decodeCp1251(response.bodyBytes);

    Group resultGroup = GroupEventsParser().parseCsv(targetGroup, responseBody);
    return resultGroup;
  }
}
