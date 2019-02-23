import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/group/group.dart';
import 'package:nure_schedule/api/model/group/speciality.dart';
part 'direction.jser.dart';

@GenSerializer()
class DirectionSerializer extends Serializer<Direction> with _$DirectionSerializer {}

class Direction extends Speciality {
  int id;
  List<Speciality> specialities;
}
