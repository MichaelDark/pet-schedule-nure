class CistDocType {
  static final CistDocType html = CistDocType._(1);
  static final CistDocType excel = CistDocType._(2);
  static final CistDocType csv = CistDocType._(3);

  final int id;
  CistDocType._(this.id);

  @override
  String toString() => 'ATypeDoc=$id';
}
