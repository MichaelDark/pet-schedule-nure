import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'tutor.jser.dart';

@GenSerializer()
class TutorSerializer extends Serializer<Tutor> with _$TutorSerializer {}

class Tutor {
  int id;

  Tutor();
  Tutor.withId(this.id);
}
