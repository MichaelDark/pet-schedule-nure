import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/event_list.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/widgets/day_pager.dart';
import 'package:nure_schedule/widgets/day_pager_controller.dart';
import 'package:nure_schedule/widgets/nure_day_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    forcePortrait();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nure Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EventList eventList;
  DateTime currentDatetime;
  DayPagerController pagerController = DayPagerController(
    daysPerPage: 3,
    initialDay: DateTime.now(),
    minDate: DateTime(2018),
  );

  void load() async {
    Group group = Group.withId(5721659);
    eventList = await CistApiClient.getGroupEvents(
      group: group,
      dateStart: DateTime(2019, 01, 01),
      dateEnd: DateTime(2019, 07, 01),
    );
    print(eventList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (eventList == null) {
      load();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        onPressed: () {
          pagerController.jumpTo(context, DateTime.now());
        },
      ),
      appBar: AppBar(
        title: Text('Nure Schedule'),
        centerTitle: true,
      ),
      body: eventList == null
          ? Center(child: CircularProgressIndicator())
          : DayPager(
              pagerController: pagerController,
              builder: (DateTime day) {
                return NureDayView(
                  date: day,
                  events: eventList.getEvents(day),
                );
              },
            ),
    );
  }
}
