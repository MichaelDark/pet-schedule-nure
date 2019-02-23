import 'package:flutter/material.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/group/group.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:nure_schedule/data/file_database.dart';
import 'package:nure_schedule/widgets/day_pager.dart';
import 'package:nure_schedule/widgets/day_pager_controller.dart';
import 'package:nure_schedule/widgets/nure_day_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  GroupEvents _groupEvents;
  DateTime currentDatetime;
  Group _group = Group(id: 5721659, name: 'ПЗПІ-16-2');
  DayPagerController pagerController = DayPagerController(
    daysPerPage: 3,
    initialDay: DateTime.now(),
    minDate: DateTime(2018),
  );

  void load({bool forceReload = false}) async {
    setState(() {
      isLoading = true;
    });
    // _groupEvents = await FileDatabase().loadGroupEvents(_group);
    // if (forceReload) {
      _groupEvents = await CistApiClient().getGroupEvents(
        group: _group,
        dateStart: DateTime(2019, 02, 01),
        dateEnd: DateTime(2019, 07, 01),
      );
    //   await FileDatabase().saveGroupEvents(_groupEvents);
    //   print('HTTP loaded');
    // }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_groupEvents == null && !isLoading) {
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
        title: Text(_group?.name ?? 'Nure Schedule'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (_groupEvents != null) load(forceReload: true);
            },
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _groupEvents == null
              ? Center(child: Text('No schedule'))
              : DayPager(
                  pagerController: pagerController,
                  builder: (DateTime day) {
                    return NureDayView(
                      date: day,
                      events: _groupEvents.getEvents(day),
                    );
                  },
                ),
    );
  }
}
