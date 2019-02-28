import 'package:flutter/material.dart';
import 'package:nure_schedule/api/model/group.dart';
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
    print('build Groups');
    loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
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
                return GroupListTile(
                  group: currentGroup,
                  onTap: () {
                    ScopedModel.of<MainModel>(context).selectedGroup = currentGroup;
                    Navigator.pushReplacementNamed(context, '/home');
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

class GroupListTile extends StatefulWidget {
  final Group group;
  final void Function() onTap;

  GroupListTile({this.group, this.onTap});

  @override
  State<StatefulWidget> createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.group.name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            FutureBuilder(
              future: ScopedModel.of<MainModel>(context).isGroupSaved(widget.group),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  return Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Container();
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
