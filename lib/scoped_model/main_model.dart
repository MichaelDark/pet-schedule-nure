import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:scoped_model/scoped_model.dart';

Group pzpiGroup = Group(id: 5721659, name: 'ПЗПІ-16-2');

class MainModel extends Model {
  static const Duration minInitTime = Duration(seconds: 1);

  SqfliteAdapter _adapter;
  EventBean _eventBean;
  GroupBean _groupBean;

  String errorText;
  Group selectedGroup;

  MainModel(); //: selectedGroup = pzpiGroup;

  Future<void> initModel() async {
    Stopwatch watch = Stopwatch();
    watch.start();

    _adapter = SqfliteAdapter('schedule_nure.db', version: 1);
    await _adapter.connect();

    _eventBean = EventBean(_adapter);
    await _eventBean.createTable(ifNotExists: true);

    _groupBean = GroupBean(
      adapter: _adapter,
      eventBean: _eventBean,
    );
    await _groupBean.createTable(ifNotExists: true);

    watch.stop();
    Duration elapsed = watch.elapsed;
    if (elapsed < minInitTime) await Future.delayed(minInitTime - elapsed);

    notifyListeners();
  }

  bool get hasError => errorText != null;
  bool get hasSelectedGroup => selectedGroup != null && selectedGroup.isNotEmpty();

  Future<Group> loadGroupEvents() async {
    print('EVENTS LOAD START');

    Group group = await _groupBean.find(selectedGroup.id, preload: true, cascade: true);

    print('EVENTS LOAD END');
    return group;
  }

  Future<void> refreshGroupEvents() async => cacheGroupEvents(selectedGroup);

  Future<bool> isGroupSaved(Group group) async {
    try {
      Group localGroup = await _groupBean.find(group.id);
      return localGroup != null;
    } catch (ignored) {
      return false;
    }
  }

  Future<void> cacheGroupEvents(Group targetGroup) async {
    print('EVENTS CACHE START');
    try {
      Group resultGroup = await CistApiClient().getGroupEvents(
        targetGroup: targetGroup,
        dateStart: DateTime(2019, 02, 01),
        dateEnd: DateTime(2019, 07, 01),
      );
      selectedGroup = resultGroup;
      if (await isGroupSaved(resultGroup)) {
        await _groupBean.remove(targetGroup.id, true);
      }
      await _groupBean.insert(
        resultGroup,
        cascade: true,
      );
    } on String catch (exception) {
      errorText = exception;
    }

    print('EVENTS CACHE END');
    notifyListeners();
  }

  Future<List<Group>> getGroups() async {
    return [pzpiGroup];
  }
}
