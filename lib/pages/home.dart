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
    print('[HomePage][build]');
    loadData();

    pagerController = ScheduleController(
      context,
      daysPerPage: 3,
      initialDay: DateTime.now(),
      minDate: DateTime(2018),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group),
        onPressed: () {
          Navigator.of(context).pushNamed('/groups').then((newGroup) {
            if (newGroup is Group && newGroup != null) {
              ScopedModel.of<MainModel>(context).selectedGroup = newGroup;
              reloadData();
            }
          });
          // pagerController.jumpTo(DateTime.now());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                //todo drawer
              },
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                ScopedModel.of<MainModel>(context).selectedGroup?.name ?? appName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            if (hasLoadedData) {
              if (!loadedData.hasEvents()) {
                return Center(
                  child: Text(
                    'Update schedule',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                );
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
      ),
    );
  }
}
