import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

class Genre {
  final String name;
  final String imageUrl;

  Genre({required this.name, required this.imageUrl});
}

@JsonSerializable()
class APIBookQuery {
  int count;
  String? next;
  String? previous;
  List<APIBook> results;

  APIBookQuery(
      {required this.count,
      required this.next,
      required this.previous,
      required this.results});

  factory APIBookQuery.fromJson(Map<String, dynamic> json) =>
      _$APIBookQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIBookQueryToJson(this);
}

@JsonSerializable()
class APIBook {
  int id;
  String title;
  List<APIPerson>? authors;
  List<String> subjects;
  List<String> bookshelves;
  List<String> languages;
  bool copyright;
  @JsonKey(name: 'media_type')
  String mediaType;
  Map<String, String> formats;
  @JsonKey(name: 'download_count')
  double downloadCount;

  APIBook({
    required this.id,
    required this.title,
    this.authors,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    this.downloadCount = 0,
  });

  factory APIBook.fromJson(Map<String, dynamic> json) =>
      _$APIBookFromJson(json);

  Map<String, dynamic> toJson() => _$APIBookToJson(this);
}

@JsonSerializable()
class APIPerson {
  String name;
  @JsonKey(name: 'birth_year')
  int? birthYear;
  @JsonKey(name: 'death_year')
  int? deathYear;

  APIPerson({required this.name, this.birthYear, this.deathYear});

  factory APIPerson.fromJson(Map<String, dynamic> json) =>
      _$APIPersonFromJson(json);

  Map<String, dynamic> toJson() => _$APIPersonToJson(this);
}
