import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'group.jser.dart';

@GenSerializer()
class GroupSerializer extends Serializer<Group> with _$GroupSerializer {}

class Group {
  int id;
  String name;

  Group({
    this.id,
    this.name,
  });
}
