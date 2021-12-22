// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIBookQuery _$APIBookQueryFromJson(Map<String, dynamic> json) {
  return APIBookQuery(
    count: json['count'] as int,
    next: json['next'] as String?,
    previous: json['previous'] as String?,
    results: (json['results'] as List<dynamic>)
        .map((e) => APIBook.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$APIBookQueryToJson(APIBookQuery instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

APIBook _$APIBookFromJson(Map<String, dynamic> json) {
  return APIBook(
    id: json['id'] as int,
    title: json['title'] as String,
    authors: (json['authors'] as List<dynamic>?)
        ?.map((e) => APIPerson.fromJson(e as Map<String, dynamic>))
        .toList(),
    subjects:
        (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
    bookshelves:
        (json['bookshelves'] as List<dynamic>).map((e) => e as String).toList(),
    languages:
        (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
    copyright: json['copyright'] as bool,
    mediaType: json['media_type'] as String,
    formats: Map<String, String>.from(json['formats'] as Map),
    downloadCount: (json['download_count'] as num).toDouble(),
  );
}

Map<String, dynamic> _$APIBookToJson(APIBook instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'subjects': instance.subjects,
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'media_type': instance.mediaType,
      'formats': instance.formats,
      'download_count': instance.downloadCount,
    };

APIPerson _$APIPersonFromJson(Map<String, dynamic> json) {
  return APIPerson(
    name: json['name'] as String,
    birthYear: json['birth_year'] as int?,
    deathYear: json['death_year'] as int?,
  );
}

Map<String, dynamic> _$APIPersonToJson(APIPerson instance) => <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
