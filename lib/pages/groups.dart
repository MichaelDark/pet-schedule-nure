import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/scoped_model/main_model.dart';
import 'package:nure_schedule/widgets/states/data_state.dart';
import 'package:scoped_model/scoped_model.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends DataState<GroupsPage> with LoadDataHelper<GroupsPage, List<Group>> {
  @override
  Future<List<Group>> get dataLoader => ScopedModel.of<MainModel>(context).getGroups();

  @override
  Widget build(BuildContext context) {
    log('GroupsPage', 'build');
    loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (hasLoadedData) {
            return ListView.builder(
              itemCount: loadedData.length,
              itemBuilder: (BuildContext context, int index) {
                Group currentGroup = loadedData[index];

                return ListTile(
                  title: Text(currentGroup.name),
                  trailing: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      ScopedModel.of<MainModel>(context).cacheGroupEvents(currentGroup);
                    },
                  ),
                  onTap: () {
                    ScopedModel.of<MainModel>(context).selectedGroup = currentGroup;
                    Navigator.of(context).pop<Group>(currentGroup);
                  },
                );
              },
            );
          }
          if (hasError) {
            return Center(child: Text(errorText));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
