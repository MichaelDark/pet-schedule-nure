import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:nure_schedule/api/cist_api_client.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/storage.dart';
import 'package:scoped_model/scoped_model.dart';

Group pzpiGroup = Group(id: 5721659, name: 'ПЗПІ-16-2');

class MainModel extends Model {
  static const Duration minInitTime = Duration(seconds: 1);

  final SqfliteAdapter _adapter;

  String errorText;
  Group _selectedGroup;
  Group get selectedGroup => _selectedGroup;
  set selectedGroup(Group group) {
    _selectedGroup = group;
    Storage().setLastGroupId(group.id);
  }

  SqfliteAdapter get adapter => _adapter;

  MainModel() : _adapter = SqfliteAdapter('schedule_nure.db', version: 3);

  Future<void> initModel() async {
    Stopwatch watch = Stopwatch();
    watch.start();

    await _adapter.connect();
    // await EventBean(_adapter).drop();
    // await GroupBean(_adapter).drop();
    await EventBean(_adapter).createTable(ifNotExists: true);
    await GroupBean(_adapter).createTable(ifNotExists: true);

    int lastGroupId = await Storage().getLastGroupId();
    if (lastGroupId != null) {
      _selectedGroup = await GroupBean(_adapter).find(lastGroupId);
    }

    watch.stop();
    Duration elapsed = watch.elapsed;
    if (elapsed < minInitTime) await Future.delayed(minInitTime - elapsed);

    notifyListeners();
  }

  bool get hasError => errorText != null;
  bool get hasSelectedGroup => selectedGroup != null && selectedGroup.isNotEmpty();

  Future<Group> loadGroupEvents() async {
    log('MainModel', 'loadGroupEvents', 'start');

    Group group = await GroupBean(adapter).find(selectedGroup.id, preload: true, cascade: true) ?? selectedGroup;

    log('MainModel', 'loadGroupEvents', 'end');
    return group;
  }

  Future<void> refreshGroupEvents() async => cacheGroupEvents(selectedGroup);

  Future<bool> isGroupSaved(Group group) async {
    try {
      Group localGroup = await GroupBean(adapter).find(group.id);
      return localGroup != null;
    } catch (ignored) {
      return false;
    }
  }

  Future<void> cacheGroupEvents(Group targetGroup) async {
    log('MainModel', 'cacheGroupEvents', 'start');

    try {
      Group resultGroup = await CistApiClient().getGroupEvents(
        targetGroup: targetGroup,
      );
      selectedGroup = resultGroup;
      await GroupBean(adapter).remove(selectedGroup.id, true);
      await GroupBean(adapter).insert(
        resultGroup,
        cascade: true,
      );
    } on String catch (exception) {
      errorText = exception;
    }

    log('MainModel', 'cacheGroupEvents', 'end');
    notifyListeners();
  }

  Future<List<Group>> getGroups() async {
    return [pzpiGroup];
  }
}
