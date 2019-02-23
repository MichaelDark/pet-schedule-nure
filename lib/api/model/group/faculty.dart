import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/group/direction.dart';
import 'package:nure_schedule/api/model/group/named_entity.dart';
part 'faculty.jser.dart';

@GenSerializer()
class FacultySerializer extends Serializer<Faculty> with _$FacultySerializer {}

class Faculty extends NamedEntity {
  int id;
  List<Direction> directions;
}
