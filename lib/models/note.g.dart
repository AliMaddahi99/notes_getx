// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetNoteCollection on Isar {
  IsarCollection<Note> get notes => getCollection();
}

const NoteSchema = CollectionSchema(
  name: 'Note',
  schema:
      '{"name":"Note","idName":"id","properties":[{"name":"dateTime","type":"String"},{"name":"folderName","type":"String"},{"name":"isFolder","type":"Bool"},{"name":"note","type":"String"},{"name":"title","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'dateTime': 0,
    'folderName': 1,
    'isFolder': 2,
    'note': 3,
    'title': 4
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _noteGetId,
  setId: _noteSetId,
  getLinks: _noteGetLinks,
  attachLinks: _noteAttachLinks,
  serializeNative: _noteSerializeNative,
  deserializeNative: _noteDeserializeNative,
  deserializePropNative: _noteDeserializePropNative,
  serializeWeb: _noteSerializeWeb,
  deserializeWeb: _noteDeserializeWeb,
  deserializePropWeb: _noteDeserializePropWeb,
  version: 3,
);

int? _noteGetId(Note object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _noteSetId(Note object, int id) {
  object.id = id;
}

List<IsarLinkBase> _noteGetLinks(Note object) {
  return [];
}

void _noteSerializeNative(IsarCollection<Note> collection, IsarRawObject rawObj,
    Note object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.dateTime;
  final _dateTime = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_dateTime.length) as int;
  final value1 = object.folderName;
  IsarUint8List? _folderName;
  if (value1 != null) {
    _folderName = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_folderName?.length ?? 0) as int;
  final value2 = object.isFolder;
  final _isFolder = value2;
  final value3 = object.note;
  final _note = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_note.length) as int;
  final value4 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_title.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _dateTime);
  writer.writeBytes(offsets[1], _folderName);
  writer.writeBool(offsets[2], _isFolder);
  writer.writeBytes(offsets[3], _note);
  writer.writeBytes(offsets[4], _title);
}

Note _noteDeserializeNative(IsarCollection<Note> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Note();
  object.dateTime = reader.readString(offsets[0]);
  object.folderName = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isFolder = reader.readBool(offsets[2]);
  object.note = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  return object;
}

P _noteDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _noteSerializeWeb(IsarCollection<Note> collection, Note object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'dateTime', object.dateTime);
  IsarNative.jsObjectSet(jsObj, 'folderName', object.folderName);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isFolder', object.isFolder);
  IsarNative.jsObjectSet(jsObj, 'note', object.note);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  return jsObj;
}

Note _noteDeserializeWeb(IsarCollection<Note> collection, dynamic jsObj) {
  final object = Note();
  object.dateTime = IsarNative.jsObjectGet(jsObj, 'dateTime') ?? '';
  object.folderName = IsarNative.jsObjectGet(jsObj, 'folderName');
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.isFolder = IsarNative.jsObjectGet(jsObj, 'isFolder') ?? false;
  object.note = IsarNative.jsObjectGet(jsObj, 'note') ?? '';
  object.title = IsarNative.jsObjectGet(jsObj, 'title') ?? '';
  return object;
}

P _noteDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'dateTime':
      return (IsarNative.jsObjectGet(jsObj, 'dateTime') ?? '') as P;
    case 'folderName':
      return (IsarNative.jsObjectGet(jsObj, 'folderName')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'isFolder':
      return (IsarNative.jsObjectGet(jsObj, 'isFolder') ?? false) as P;
    case 'note':
      return (IsarNative.jsObjectGet(jsObj, 'note') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _noteAttachLinks(IsarCollection col, int id, Note object) {}

extension NoteQueryWhereSort on QueryBuilder<Note, Note, QWhere> {
  QueryBuilder<Note, Note, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension NoteQueryWhere on QueryBuilder<Note, Note, QWhereClause> {
  QueryBuilder<Note, Note, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension NoteQueryFilter on QueryBuilder<Note, Note, QFilterCondition> {
  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dateTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'dateTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> dateTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'dateTime',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'folderName',
      value: null,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'folderName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> folderNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'folderName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> isFolderEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isFolder',
      value: value,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'note',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'note',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> noteMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'note',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'title',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension NoteQueryLinks on QueryBuilder<Note, Note, QFilterCondition> {}

extension NoteQueryWhereSortBy on QueryBuilder<Note, Note, QSortBy> {
  QueryBuilder<Note, Note, QAfterSortBy> sortByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByFolderName() {
    return addSortByInternal('folderName', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByFolderNameDesc() {
    return addSortByInternal('folderName', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsFolder() {
    return addSortByInternal('isFolder', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsFolderDesc() {
    return addSortByInternal('isFolder', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByNote() {
    return addSortByInternal('note', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByNoteDesc() {
    return addSortByInternal('note', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension NoteQueryWhereSortThenBy on QueryBuilder<Note, Note, QSortThenBy> {
  QueryBuilder<Note, Note, QAfterSortBy> thenByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByFolderName() {
    return addSortByInternal('folderName', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByFolderNameDesc() {
    return addSortByInternal('folderName', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsFolder() {
    return addSortByInternal('isFolder', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsFolderDesc() {
    return addSortByInternal('isFolder', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByNote() {
    return addSortByInternal('note', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByNoteDesc() {
    return addSortByInternal('note', Sort.desc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension NoteQueryWhereDistinct on QueryBuilder<Note, Note, QDistinct> {
  QueryBuilder<Note, Note, QDistinct> distinctByDateTime(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('dateTime', caseSensitive: caseSensitive);
  }

  QueryBuilder<Note, Note, QDistinct> distinctByFolderName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('folderName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Note, Note, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Note, Note, QDistinct> distinctByIsFolder() {
    return addDistinctByInternal('isFolder');
  }

  QueryBuilder<Note, Note, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('note', caseSensitive: caseSensitive);
  }

  QueryBuilder<Note, Note, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }
}

extension NoteQueryProperty on QueryBuilder<Note, Note, QQueryProperty> {
  QueryBuilder<Note, String, QQueryOperations> dateTimeProperty() {
    return addPropertyNameInternal('dateTime');
  }

  QueryBuilder<Note, String?, QQueryOperations> folderNameProperty() {
    return addPropertyNameInternal('folderName');
  }

  QueryBuilder<Note, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Note, bool, QQueryOperations> isFolderProperty() {
    return addPropertyNameInternal('isFolder');
  }

  QueryBuilder<Note, String, QQueryOperations> noteProperty() {
    return addPropertyNameInternal('note');
  }

  QueryBuilder<Note, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }
}
