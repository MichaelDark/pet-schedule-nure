// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _EventBean implements Bean<Event> {
  final id = IntField('id');
  final lesson = StrField('lesson');
  final room = StrField('room');
  final type = StrField('type');
  final raw = StrField('raw');
  final timeStart = DateTimeField('time_start');
  final timeEnd = DateTimeField('time_end');
  final groupId = IntField('group_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        lesson.name: lesson,
        room.name: room,
        type.name: type,
        raw.name: raw,
        timeStart.name: timeStart,
        timeEnd.name: timeEnd,
        groupId.name: groupId,
      };
  Event fromMap(Map map) {
    Event model = Event();
    model.id = adapter.parseValue(map['id']);
    model.lesson = adapter.parseValue(map['lesson']);
    model.room = adapter.parseValue(map['room']);
    model.type = adapter.parseValue(map['type']);
    model.raw = adapter.parseValue(map['raw']);
    model.timeStart = adapter.parseValue(map['time_start']);
    model.timeEnd = adapter.parseValue(map['time_end']);
    model.groupId = adapter.parseValue(map['group_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Event model,
      {bool update = false, Set<String> only, bool onlyNonNull: false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(lesson.set(model.lesson));
      ret.add(room.set(model.room));
      ret.add(type.set(model.type));
      ret.add(raw.set(model.raw));
      ret.add(timeStart.set(model.timeStart));
      ret.add(timeEnd.set(model.timeEnd));
      ret.add(groupId.set(model.groupId));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(lesson.name)) ret.add(lesson.set(model.lesson));
      if (only.contains(room.name)) ret.add(room.set(model.room));
      if (only.contains(type.name)) ret.add(type.set(model.type));
      if (only.contains(raw.name)) ret.add(raw.set(model.raw));
      if (only.contains(timeStart.name))
        ret.add(timeStart.set(model.timeStart));
      if (only.contains(timeEnd.name)) ret.add(timeEnd.set(model.timeEnd));
      if (only.contains(groupId.name)) ret.add(groupId.set(model.groupId));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.lesson != null) {
        ret.add(lesson.set(model.lesson));
      }
      if (model.room != null) {
        ret.add(room.set(model.room));
      }
      if (model.type != null) {
        ret.add(type.set(model.type));
      }
      if (model.raw != null) {
        ret.add(raw.set(model.raw));
      }
      if (model.timeStart != null) {
        ret.add(timeStart.set(model.timeStart));
      }
      if (model.timeEnd != null) {
        ret.add(timeEnd.set(model.timeEnd));
      }
      if (model.groupId != null) {
        ret.add(groupId.set(model.groupId));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(lesson.name, isNullable: false);
    st.addStr(room.name, isNullable: false);
    st.addStr(type.name, isNullable: false);
    st.addStr(raw.name, isNullable: false);
    st.addDateTime(timeStart.name, isNullable: false);
    st.addDateTime(timeEnd.name, isNullable: false);
    st.addInt(groupId.name,
        foreignTable: groupBean.tableName, foreignCol: 'id', isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Event model,
      {bool cascade: false, bool onlyNonNull: false, Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Event newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Event> models,
      {bool onlyNonNull: false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Event model,
      {bool cascade: false, Set<String> only, bool onlyNonNull: false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      Event newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Event> models,
      {bool onlyNonNull: false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Event model,
      {bool cascade: false,
      bool associate: false,
      Set<String> only,
      bool onlyNonNull: false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Event> models,
      {bool onlyNonNull: false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Event> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Event> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<Event>> findByGroup(int groupId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.groupId.eq(groupId));
    return findMany(find);
  }

  Future<List<Event>> findByGroupList(List<Group> models,
      {bool preload: false, bool cascade: false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Group model in models) {
      find.or(this.groupId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByGroup(int groupId) async {
    final Remove rm = remover.where(this.groupId.eq(groupId));
    return await adapter.remove(rm);
  }

  void associateGroup(Event child, Group parent) {
    child.groupId = parent.id;
  }

  GroupBean get groupBean;
}
