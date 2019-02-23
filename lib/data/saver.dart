// import 'dart:convert';
// import 'dart:io';

// import 'package:nure_schedule/api/model/event_list.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// Future<Directory> get _documentsDirectory => getApplicationDocumentsDirectory();

// Future<void> save(GroupEvents list) async {
//   Directory documents = await _documentsDirectory;
//   String filename = 'list.fdb';

//   String folderPath = path.join(documents.path, filename);
//   File file = File(folderPath);
//   if (!await file.exists()) {
//     file = await file.create();
//   }
//   await file.writeAsString(json.encode(EventListSerializer().toMap(list)), mode: FileMode.write);
// }

// Future<GroupEvents> load() async {
//   Directory documents = await _documentsDirectory;
//   String filename = 'list.fdb';

//   String folderPath = path.join(documents.path, filename);
//   File file = File(folderPath);
//   if (await file.exists()) {
//     return EventListSerializer().fromMap(json.decode(await file.readAsString()));
//   }
//   return null;
// }
