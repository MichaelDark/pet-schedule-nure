import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/group/group.dart';
import 'package:nure_schedule/api/model/group/named_entity.dart';
part 'speciality.jser.dart';

@GenSerializer()
class SpecialitySerializer extends Serializer<Speciality> with _$SpecialitySerializer {}

class Speciality extends NamedEntity {
  int id;
  List<Group> groups;
}
