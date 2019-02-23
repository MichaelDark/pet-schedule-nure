import 'package:intl/intl.dart';
import 'package:nure_schedule/api/enum/cist_doc_type.dart';
import 'package:nure_schedule/api/model/group.dart';
import 'package:nure_schedule/api/model/tutor.dart';

class CistUrlBuilder {
  String _url;
  bool _isFirst = true;

  CistUrlBuilder._(String baseUrl) : _url = baseUrl;

  CistUrlBuilder(String baseUrl) : this._(baseUrl);

  factory CistUrlBuilder.csv(String baseUrl) {
    CistUrlBuilder builder = CistUrlBuilder._(baseUrl);
    builder.addDocType(CistDocType.csv);
    return builder;
  }

  void _addFullParam(String param) {
    _url += '${(_isFirst ? '' : '&')}$param';
    _isFirst = false;
  }

  void _addParam(String name, dynamic value) => _addFullParam('$name=$value');

  void addDocType(CistDocType docType) => _addFullParam('$docType');

  void _addFlow(int flowId) => _addParam('Aid_potok', flowId);
  void addGroups(List<Group> groups) {
    if (groups == null || groups.isEmpty) return;
    if (groups.length == 1) {
      _addParam('Aid_group', groups.first.id);
      _addFlow(0); //ignore flow, parse groups
      return;
    }

    String groupsString = '${groups.first.id}';
    groups.removeAt(0);
    groups.forEach((group) => groupsString += '_${group.id}');

    _addParam('Aid_group', groupsString);
    _addFlow(0); //ignore flow, parse groups
  }

  void _addDepartment(int departmentId) => _addParam('Aid_kaf', departmentId);
  void addTutors(List<Tutor> tutors) {
    if (tutors == null || tutors.isEmpty) return;
    if (tutors.length == 1) {
      _addParam('Aid_sotr', tutors.first.id);
      _addDepartment(0); //ignore department, parse groups
      return;
    }

    String groupsString = '${tutors.first.id}';
    tutors.removeAt(0);
    tutors.forEach((group) => groupsString += '_${group.id}');

    _addParam('Aid_sotr', groupsString);
    _addDepartment(0); //ignore department, parse groups
  }

  void addAuditory(int auditoryId) => _addParam('Aid_aud', auditoryId);

  DateFormat get dateFormatter => DateFormat("dd.MM.yyyy");
  void addDateStart(DateTime date) => _addParam('ADateStart', dateFormatter.format(date));
  void addDateEnd(DateTime date) => _addParam('ADateEnd', dateFormatter.format(date));

  String get url => '$_url&AMultiWorkSheet=0';
}
