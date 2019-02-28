import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/scoped_model/main_model.dart';
import 'package:nure_schedule/widgets/group_schedule_view.dart';
import 'package:nure_schedule/widgets/schedule_controller.dart';
import 'package:nure_schedule/widgets/states/data_state.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends DataState<HomePage> with LoadDataHelper<HomePage, Group> {
  ScheduleController pagerController;

  @override
  Future<Group> get dataLoader => ScopedModel.of<MainModel>(context).loadGroupEvents();

  @override
  Widget build(BuildContext context) {
    loadData();

    pagerController = ScheduleController(
      context,
      daysPerPage: 3,
      initialDay: DateTime.now(),
      minDate: DateTime(2018),
    );

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, _, MainModel model) {
        return Scaffold(
          floatingActionButton: hasLoadedData
              ? FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    pagerController.jumpTo(DateTime.now());
                  },
                )
              : Container(),
          appBar: AppBar(
            title: Text(model.selectedGroup?.name ?? appName),
            centerTitle: true,
            actions: <Widget>[
              model.hasSelectedGroup
                  ? IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        model.refreshGroupEvents().then((_) {
                          reloadData();
                        });
                      },
                    )
                  : Container(),
              IconButton(
                icon: Icon(Icons.group),
                onPressed: () {
                  if (!isDataLoading)
                    Navigator.pushNamed(context, '/groups').then<Group>(
                      (received) {
                        if (received is Group) {
                          model.selectedGroup = received;
                          reloadData();
                        }
                      },
                    );
                },
              )
            ],
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (hasLoadedData) {
                if (!loadedData.hasEvents()) {
                  return Center(child: Text('Update schedule', style: TextStyle(color: Colors.grey)));
                }
                return GroupScheduleView(
                  group: loadedData,
                  controller: pagerController,
                );
              }
              if (isDataLoading) {
                return Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      'Loading ...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ],
                ));
              }
              if (!hasLoadedData) {
                return Center(child: Text('Select group', style: TextStyle(color: Colors.grey)));
              }
              if (hasError) {
                return Center(child: Text(errorText, style: TextStyle(color: Colors.grey)));
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
