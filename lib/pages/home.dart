import 'package:flutter/material.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:nure_schedule/widgets/group_schedule_view.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';

final Group pzpiGroup = Group(id: 5721659, name: 'ПЗПІ-16-2');

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  GroupEvents _groupEvents;
  ScheduleController pagerController = ScheduleController(
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
      group: pzpiGroup,
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
          title: Text(pzpiGroup?.name ?? 'Nure Schedule'),
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
        body: isLoading ? Center(child: CircularProgressIndicator()) : _buildSchedule());
  }

  Widget _buildSchedule() {
    if (_groupEvents == null) {
      return Center(child: Text('No schedule'));
    }

    return GroupScheduleView(
      groupEvents: _groupEvents,
      controller: pagerController,
    );
  }
}
