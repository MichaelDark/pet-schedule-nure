import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'named_entity.jser.dart';

@GenSerializer()
class NamedEntitySerializer extends Serializer<NamedEntity> with _$NamedEntitySerializer {}

class NamedEntity {
  @Alias('short_name')
  String shortName;
  @Alias('full_name')
  String fullName;
}
