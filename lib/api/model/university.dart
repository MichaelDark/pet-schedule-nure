import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:nure_schedule/api/model/direction.dart';
import 'package:nure_schedule/api/model/named_entity.dart';
part 'university.jser.dart';

@GenSerializer()
class UniversitySerializer extends Serializer<University> with _$UniversitySerializer {}

class University extends NamedEntity {
  List<Direction> faculties;
}

@GenSerializer()
class UniversityWrapperSerializer extends Serializer<UniversityWrapper> with _$UniversityWrapperSerializer {}

class UniversityWrapper {
  University university;
}
