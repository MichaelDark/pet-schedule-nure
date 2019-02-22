// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/event_list.dart';
import 'package:nure_schedule/api/model/group.dart';

void main() {
  test('Test API parser', () async {
    Group group = Group.withId(5721659);
    EventList eventList = await CistApiClient.getGroupEvents(
      group: group,
      dateStart: DateTime(2019, 01, 01),
      dateEnd: DateTime(2019, 07, 01),
    );
    print(eventList);
  });
}
