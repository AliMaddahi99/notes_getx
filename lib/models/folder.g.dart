// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetFolderCollection on Isar {
  IsarCollection<Folder> get folders => getCollection();
}

const FolderSchema = CollectionSchema(
  name: 'Folder',
  schema:
      '{"name":"Folder","idName":"id","properties":[{"name":"folderName","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'folderName': 0},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _folderGetId,
  setId: _folderSetId,
  getLinks: _folderGetLinks,
  attachLinks: _folderAttachLinks,
  serializeNative: _folderSerializeNative,
  deserializeNative: _folderDeserializeNative,
  deserializePropNative: _folderDeserializePropNative,
  serializeWeb: _folderSerializeWeb,
  deserializeWeb: _folderDeserializeWeb,
  deserializePropWeb: _folderDeserializePropWeb,
  version: 3,
);

int? _folderGetId(Folder object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _folderSetId(Folder object, int id) {
  object.id = id;
}

List<IsarLinkBase> _folderGetLinks(Folder object) {
  return [];
}

void _folderSerializeNative(
    IsarCollection<Folder> collection,
    IsarRawObject rawObj,
    Folder object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.folderName;
  final _folderName = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_folderName.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _folderName);
}

Folder _folderDeserializeNative(IsarCollection<Folder> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Folder();
  object.folderName = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _folderDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _folderSerializeWeb(IsarCollection<Folder> collection, Folder object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'folderName', object.folderName);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  return jsObj;
}

Folder _folderDeserializeWeb(IsarCollection<Folder> collection, dynamic jsObj) {
  final object = Folder();
  object.folderName = IsarNative.jsObjectGet(jsObj, 'folderName') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _folderDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'folderName':
      return (IsarNative.jsObjectGet(jsObj, 'folderName') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _folderAttachLinks(IsarCollection col, int id, Folder object) {}

extension FolderQueryWhereSort on QueryBuilder<Folder, Folder, QWhere> {
  QueryBuilder<Folder, Folder, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension FolderQueryWhere on QueryBuilder<Folder, Folder, QWhereClause> {
  QueryBuilder<Folder, Folder, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Folder, Folder, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Folder, Folder, QAfterWhereClause> idBetween(
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

extension FolderQueryFilter on QueryBuilder<Folder, Folder, QFilterCondition> {
  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameGreaterThan(
    String value, {
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameLessThan(
    String value, {
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameStartsWith(
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameEndsWith(
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'folderName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> folderNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'folderName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Folder, Folder, QAfterFilterCondition> idBetween(
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
}

extension FolderQueryLinks on QueryBuilder<Folder, Folder, QFilterCondition> {}

extension FolderQueryWhereSortBy on QueryBuilder<Folder, Folder, QSortBy> {
  QueryBuilder<Folder, Folder, QAfterSortBy> sortByFolderName() {
    return addSortByInternal('folderName', Sort.asc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortByFolderNameDesc() {
    return addSortByInternal('folderName', Sort.desc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension FolderQueryWhereSortThenBy
    on QueryBuilder<Folder, Folder, QSortThenBy> {
  QueryBuilder<Folder, Folder, QAfterSortBy> thenByFolderName() {
    return addSortByInternal('folderName', Sort.asc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByFolderNameDesc() {
    return addSortByInternal('folderName', Sort.desc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Folder, Folder, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension FolderQueryWhereDistinct on QueryBuilder<Folder, Folder, QDistinct> {
  QueryBuilder<Folder, Folder, QDistinct> distinctByFolderName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('folderName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Folder, Folder, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }
}

extension FolderQueryProperty on QueryBuilder<Folder, Folder, QQueryProperty> {
  QueryBuilder<Folder, String, QQueryOperations> folderNameProperty() {
    return addPropertyNameInternal('folderName');
  }

  QueryBuilder<Folder, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
