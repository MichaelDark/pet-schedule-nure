import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:meta/meta.dart';
import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/model/time_range.dart';
import 'package:nure_schedule/util/date_utils.dart';

part 'group.jorm.dart';

class Group {
  @PrimaryKey()
  int id;

  String name;

  @HasMany(EventBean)
  List<Event> events;

  Group({this.id, this.name}) : events = [];

  Group.copyMeta(Group group)
      : this(
          id: group.id,
          name: group.name,
        );

  List<Event> getEvents(DateTime date) => events.where((Event event) => correspondsDate(date, event.timeStart)).toList();

  List<ITimeRange> getNurePairsRanges() {
    Map<int, ITimeRange> map = {};
    events.forEach((Event event) => map.putIfAbsent(event.timeId, () => TimeRange.copy(event)));

    List<ITimeRange> nurePairs = map.values.toList();
    nurePairs.sort((time1, time2) => time1.timeId.compareTo(time2.timeId));
    return nurePairs;
  }

  bool isNotEmpty() => id != null;
  bool hasEvents() => events != null && events.isNotEmpty;

  @override
  String toString() => 'Group $id: $name\r\nGroup $id: ${events.length} events';
}

@GenBean()
class GroupBean extends Bean<Group> with _GroupBean {
  GroupBean(Adapter adapter) : super(adapter);

  @override
  String get tableName => 'groups';

  @override
  EventBean get eventBean => EventBean(adapter);
}
