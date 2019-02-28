import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/api/model/group_events.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileDatabase {
  Future<void> saveGroupEvents(GroupEvents groupEvents) async {
    try {
      Directory documents = await _documentsDirectory;
      String filename = 'list.json';

      String folderPath = path.join(documents.path, filename);
      File file = File(folderPath);
      if (!await file.exists()) {
        file = await file.create();
      }
      await file.writeAsString(
        json.encode(GroupEventsSerializer().toMap(groupEvents)),
        mode: FileMode.write,
      );

      print('save success');
    } catch (ignored) {}
  }

  Future<GroupEvents> loadGroupEvents(Group group) async {
    Directory documents = await _documentsDirectory;
    String filename = 'list.json';

    String folderPath = path.join(documents.path, filename);
    File file = File(folderPath);
    try {
      if (await file.exists()) {
        String rawJson = await file.readAsString();
        GroupEvents groupEvents = GroupEventsSerializer().fromMap(json.decode(rawJson));
        if (groupEvents.group == null || groupEvents.group.id == null) {
          return null;
        }
        print('load success');
        return groupEvents;
      }
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  Future<Directory> get _documentsDirectory => getApplicationDocumentsDirectory();
}
