import 'dart:convert';
import 'dart:io';

import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileDatabase {
  Future<void> save<TObject extends Identity, TSerializer extends Serializer<TObject>>(TObject object, TSerializer serializer) async {
    Directory documents = await _documentsDirectory;
    String folderName = "db";
    String filename = '${object.getId()}.fdb';

    String folderPath = path.join(documents.path, folderName, filename);
    File file = File(folderPath);

    String jsonObject = json.encode(serializer.toMap(object));
    await file.writeAsString(jsonObject);
  }

  Future<TObject> load<TKey, TObject extends Identity<TKey>, TSerializer extends Serializer<TObject>>(TKey key, TSerializer serializer) async {
    try {
      Directory documents = await _documentsDirectory;
      String folderName = "db";
      String filename = '$key.fdb';

      String folderPath = path.join(documents.path, folderName, filename);
      File file = File(folderPath);

      String jsonObject = await file.readAsString();
      Map<String, dynamic> mapObject = json.decode(jsonObject);
      return serializer.fromMap(mapObject);
    } catch (ignored) {
      return null;
    }
  }

  Future<Directory> get _documentsDirectory => getApplicationDocumentsDirectory();
}

abstract class Identity<T> {
  T getId();
}
