// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDictionaryEntryCollection on Isar {
  IsarCollection<DictionaryEntry> get dictionaryEntrys => this.collection();
}

const DictionaryEntrySchema = CollectionSchema(
  name: r'DictionaryEntry',
  id: 433168435156867289,
  properties: {
    r'amharicTranslation': PropertySchema(
      id: 0,
      name: r'amharicTranslation',
      type: IsarType.string,
    ),
    r'audioUrl': PropertySchema(
      id: 1,
      name: r'audioUrl',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'englishTranslation': PropertySchema(
      id: 3,
      name: r'englishTranslation',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 4,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'kebenaWord': PropertySchema(
      id: 5,
      name: r'kebenaWord',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'videoUrl': PropertySchema(
      id: 7,
      name: r'videoUrl',
      type: IsarType.string,
    )
  },
  estimateSize: _dictionaryEntryEstimateSize,
  serialize: _dictionaryEntrySerialize,
  deserialize: _dictionaryEntryDeserialize,
  deserializeProp: _dictionaryEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'kebenaWord': IndexSchema(
      id: -4657502638700030664,
      name: r'kebenaWord',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'kebenaWord',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dictionaryEntryGetId,
  getLinks: _dictionaryEntryGetLinks,
  attach: _dictionaryEntryAttach,
  version: '3.1.0+1',
);

int _dictionaryEntryEstimateSize(
  DictionaryEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.amharicTranslation.length * 3;
  {
    final value = object.audioUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.englishTranslation.length * 3;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.kebenaWord.length * 3;
  {
    final value = object.videoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dictionaryEntrySerialize(
  DictionaryEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.amharicTranslation);
  writer.writeString(offsets[1], object.audioUrl);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.englishTranslation);
  writer.writeString(offsets[4], object.imageUrl);
  writer.writeString(offsets[5], object.kebenaWord);
  writer.writeDateTime(offsets[6], object.updatedAt);
  writer.writeString(offsets[7], object.videoUrl);
}

DictionaryEntry _dictionaryEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DictionaryEntry();
  object.amharicTranslation = reader.readString(offsets[0]);
  object.audioUrl = reader.readStringOrNull(offsets[1]);
  object.category = reader.readStringOrNull(offsets[2]);
  object.englishTranslation = reader.readString(offsets[3]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[4]);
  object.kebenaWord = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[6]);
  object.videoUrl = reader.readStringOrNull(offsets[7]);
  return object;
}

P _dictionaryEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dictionaryEntryGetId(DictionaryEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dictionaryEntryGetLinks(DictionaryEntry object) {
  return [];
}

void _dictionaryEntryAttach(
    IsarCollection<dynamic> col, Id id, DictionaryEntry object) {
  object.id = id;
}

extension DictionaryEntryQueryWhereSort
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QWhere> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhere> anyKebenaWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'kebenaWord'),
      );
    });
  }
}

extension DictionaryEntryQueryWhere
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QWhereClause> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordEqualTo(String kebenaWord) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'kebenaWord',
        value: [kebenaWord],
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordNotEqualTo(String kebenaWord) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kebenaWord',
              lower: [],
              upper: [kebenaWord],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kebenaWord',
              lower: [kebenaWord],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kebenaWord',
              lower: [kebenaWord],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kebenaWord',
              lower: [],
              upper: [kebenaWord],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordGreaterThan(
    String kebenaWord, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'kebenaWord',
        lower: [kebenaWord],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordLessThan(
    String kebenaWord, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'kebenaWord',
        lower: [],
        upper: [kebenaWord],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordBetween(
    String lowerKebenaWord,
    String upperKebenaWord, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'kebenaWord',
        lower: [lowerKebenaWord],
        includeLower: includeLower,
        upper: [upperKebenaWord],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordStartsWith(String KebenaWordPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'kebenaWord',
        lower: [KebenaWordPrefix],
        upper: ['$KebenaWordPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'kebenaWord',
        value: [''],
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterWhereClause>
      kebenaWordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'kebenaWord',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'kebenaWord',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'kebenaWord',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'kebenaWord',
              upper: [''],
            ));
      }
    });
  }
}

extension DictionaryEntryQueryFilter
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QFilterCondition> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amharicTranslation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'amharicTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'amharicTranslation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amharicTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      amharicTranslationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'amharicTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      audioUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishTranslation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishTranslation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      englishTranslationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kebenaWord',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kebenaWord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kebenaWord',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kebenaWord',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      kebenaWordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kebenaWord',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'videoUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'videoUrl',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'videoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'videoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'videoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterFilterCondition>
      videoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'videoUrl',
        value: '',
      ));
    });
  }
}

extension DictionaryEntryQueryObject
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QFilterCondition> {}

extension DictionaryEntryQueryLinks
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QFilterCondition> {}

extension DictionaryEntryQuerySortBy
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QSortBy> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByAmharicTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amharicTranslation', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByAmharicTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amharicTranslation', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByEnglishTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishTranslation', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByEnglishTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishTranslation', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByKebenaWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kebenaWord', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByKebenaWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kebenaWord', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByVideoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      sortByVideoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoUrl', Sort.desc);
    });
  }
}

extension DictionaryEntryQuerySortThenBy
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QSortThenBy> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByAmharicTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amharicTranslation', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByAmharicTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amharicTranslation', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByAudioUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByAudioUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUrl', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByEnglishTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishTranslation', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByEnglishTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishTranslation', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByKebenaWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kebenaWord', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByKebenaWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kebenaWord', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByVideoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoUrl', Sort.asc);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QAfterSortBy>
      thenByVideoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoUrl', Sort.desc);
    });
  }
}

extension DictionaryEntryQueryWhereDistinct
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct> {
  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct>
      distinctByAmharicTranslation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amharicTranslation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct> distinctByAudioUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct>
      distinctByEnglishTranslation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishTranslation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct>
      distinctByKebenaWord({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kebenaWord', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<DictionaryEntry, DictionaryEntry, QDistinct> distinctByVideoUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'videoUrl', caseSensitive: caseSensitive);
    });
  }
}

extension DictionaryEntryQueryProperty
    on QueryBuilder<DictionaryEntry, DictionaryEntry, QQueryProperty> {
  QueryBuilder<DictionaryEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DictionaryEntry, String, QQueryOperations>
      amharicTranslationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amharicTranslation');
    });
  }

  QueryBuilder<DictionaryEntry, String?, QQueryOperations> audioUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUrl');
    });
  }

  QueryBuilder<DictionaryEntry, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<DictionaryEntry, String, QQueryOperations>
      englishTranslationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishTranslation');
    });
  }

  QueryBuilder<DictionaryEntry, String?, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<DictionaryEntry, String, QQueryOperations> kebenaWordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kebenaWord');
    });
  }

  QueryBuilder<DictionaryEntry, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<DictionaryEntry, String?, QQueryOperations> videoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videoUrl');
    });
  }
}
