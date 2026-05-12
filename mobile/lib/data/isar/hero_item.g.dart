// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHeroItemCollection on Isar {
  IsarCollection<HeroItem> get heroItems => this.collection();
}

const HeroItemSchema = CollectionSchema(
  name: r'HeroItem',
  id: -2790180483707716529,
  properties: {
    r'birthYear': PropertySchema(
      id: 0,
      name: r'birthYear',
      type: IsarType.string,
    ),
    r'braveryQuote': PropertySchema(
      id: 1,
      name: r'braveryQuote',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'deathYear': PropertySchema(
      id: 3,
      name: r'deathYear',
      type: IsarType.string,
    ),
    r'era': PropertySchema(
      id: 4,
      name: r'era',
      type: IsarType.string,
    ),
    r'fullStory': PropertySchema(
      id: 5,
      name: r'fullStory',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 6,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'legacy': PropertySchema(
      id: 7,
      name: r'legacy',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'serverId': PropertySchema(
      id: 9,
      name: r'serverId',
      type: IsarType.long,
    ),
    r'shortBio': PropertySchema(
      id: 10,
      name: r'shortBio',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 11,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _heroItemEstimateSize,
  serialize: _heroItemSerialize,
  deserialize: _heroItemDeserialize,
  deserializeProp: _heroItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _heroItemGetId,
  getLinks: _heroItemGetLinks,
  attach: _heroItemAttach,
  version: '3.1.0+1',
);

int _heroItemEstimateSize(
  HeroItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.birthYear;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.braveryQuote;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.category.length * 3;
  {
    final value = object.deathYear;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.era.length * 3;
  bytesCount += 3 + object.fullStory.length * 3;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.legacy.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.shortBio.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _heroItemSerialize(
  HeroItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.birthYear);
  writer.writeString(offsets[1], object.braveryQuote);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.deathYear);
  writer.writeString(offsets[4], object.era);
  writer.writeString(offsets[5], object.fullStory);
  writer.writeString(offsets[6], object.imageUrl);
  writer.writeString(offsets[7], object.legacy);
  writer.writeString(offsets[8], object.name);
  writer.writeLong(offsets[9], object.serverId);
  writer.writeString(offsets[10], object.shortBio);
  writer.writeString(offsets[11], object.title);
  writer.writeDateTime(offsets[12], object.updatedAt);
}

HeroItem _heroItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HeroItem();
  object.birthYear = reader.readStringOrNull(offsets[0]);
  object.braveryQuote = reader.readStringOrNull(offsets[1]);
  object.category = reader.readString(offsets[2]);
  object.deathYear = reader.readStringOrNull(offsets[3]);
  object.era = reader.readString(offsets[4]);
  object.fullStory = reader.readString(offsets[5]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[6]);
  object.legacy = reader.readString(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.serverId = reader.readLong(offsets[9]);
  object.shortBio = reader.readString(offsets[10]);
  object.title = reader.readString(offsets[11]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[12]);
  return object;
}

P _heroItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _heroItemGetId(HeroItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _heroItemGetLinks(HeroItem object) {
  return [];
}

void _heroItemAttach(IsarCollection<dynamic> col, Id id, HeroItem object) {
  object.id = id;
}

extension HeroItemQueryWhereSort on QueryBuilder<HeroItem, HeroItem, QWhere> {
  QueryBuilder<HeroItem, HeroItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HeroItemQueryWhere on QueryBuilder<HeroItem, HeroItem, QWhereClause> {
  QueryBuilder<HeroItem, HeroItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<HeroItem, HeroItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterWhereClause> idBetween(
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
}

extension HeroItemQueryFilter
    on QueryBuilder<HeroItem, HeroItem, QFilterCondition> {
  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'birthYear',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'birthYear',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'birthYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'birthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'birthYear',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> birthYearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthYear',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      birthYearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'birthYear',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'braveryQuote',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      braveryQuoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'braveryQuote',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      braveryQuoteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'braveryQuote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      braveryQuoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'braveryQuote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> braveryQuoteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'braveryQuote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      braveryQuoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'braveryQuote',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      braveryQuoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'braveryQuote',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryEqualTo(
    String value, {
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryGreaterThan(
    String value, {
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryLessThan(
    String value, {
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryStartsWith(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryEndsWith(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deathYear',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deathYear',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deathYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deathYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deathYear',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> deathYearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deathYear',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      deathYearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deathYear',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'era',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'era',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'era',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'era',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> eraIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'era',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullStory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullStory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullStory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> fullStoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullStory',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition>
      fullStoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullStory',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlEqualTo(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlGreaterThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlLessThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlBetween(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlStartsWith(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlEndsWith(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'legacy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'legacy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'legacy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'legacy',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> legacyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'legacy',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> serverIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> serverIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> serverIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverId',
        value: value,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> serverIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortBio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortBio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortBio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortBio',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> shortBioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortBio',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<HeroItem, HeroItem, QAfterFilterCondition> updatedAtBetween(
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
}

extension HeroItemQueryObject
    on QueryBuilder<HeroItem, HeroItem, QFilterCondition> {}

extension HeroItemQueryLinks
    on QueryBuilder<HeroItem, HeroItem, QFilterCondition> {}

extension HeroItemQuerySortBy on QueryBuilder<HeroItem, HeroItem, QSortBy> {
  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByBirthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthYear', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByBirthYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthYear', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByBraveryQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'braveryQuote', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByBraveryQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'braveryQuote', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByDeathYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deathYear', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByDeathYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deathYear', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByEra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'era', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByEraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'era', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByFullStory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullStory', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByFullStoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullStory', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByLegacy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legacy', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByLegacyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legacy', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByShortBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBio', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByShortBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBio', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HeroItemQuerySortThenBy
    on QueryBuilder<HeroItem, HeroItem, QSortThenBy> {
  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByBirthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthYear', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByBirthYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthYear', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByBraveryQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'braveryQuote', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByBraveryQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'braveryQuote', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByDeathYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deathYear', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByDeathYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deathYear', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByEra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'era', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByEraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'era', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByFullStory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullStory', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByFullStoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullStory', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByLegacy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legacy', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByLegacyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'legacy', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByServerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverId', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByShortBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBio', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByShortBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBio', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HeroItemQueryWhereDistinct
    on QueryBuilder<HeroItem, HeroItem, QDistinct> {
  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByBirthYear(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'birthYear', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByBraveryQuote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'braveryQuote', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByDeathYear(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deathYear', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByEra(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'era', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByFullStory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullStory', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByLegacy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'legacy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByServerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverId');
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByShortBio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortBio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HeroItem, HeroItem, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension HeroItemQueryProperty
    on QueryBuilder<HeroItem, HeroItem, QQueryProperty> {
  QueryBuilder<HeroItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HeroItem, String?, QQueryOperations> birthYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'birthYear');
    });
  }

  QueryBuilder<HeroItem, String?, QQueryOperations> braveryQuoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'braveryQuote');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<HeroItem, String?, QQueryOperations> deathYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deathYear');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> eraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'era');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> fullStoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullStory');
    });
  }

  QueryBuilder<HeroItem, String?, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> legacyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'legacy');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<HeroItem, int, QQueryOperations> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverId');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> shortBioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortBio');
    });
  }

  QueryBuilder<HeroItem, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<HeroItem, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
