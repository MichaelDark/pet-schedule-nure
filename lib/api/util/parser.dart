import 'dart:convert';

import 'package:jaguar_serializer/jaguar_serializer.dart';

abstract class IParser<SerializableType, ParsedType> {
  ParsedType parse(String source, Serializer<SerializableType> serializer);
}

class ItemParser<T> extends IParser<T, T> {
  @override
  T parse(String source, Serializer<T> serializer) {
    if (source == null || source.isEmpty) {
      return null;
    }
    Map<String, dynamic> parsedDataMap = json.decode(source);
    return serializer.fromMap(parsedDataMap);
  }
}

class ListParser<T> extends IParser<T, List<T>> {
  @override
  List<T> parse(String source, Serializer<T> serializer) {
    if (source == null || source.isEmpty) {
      return null;
    }
    List<dynamic> parsedDataList = json.decode(source);
    return serializer.fromList(parsedDataList.cast<Map>());
  }
}
