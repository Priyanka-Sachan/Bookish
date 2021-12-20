class ArticleType {
  static const editorial = 'editorial';
  static const review = 'review';
  static const upcoming = 'upcoming';
}

class Article {
  String id;
  String type;
  String title;
  String subtitle;
  String backgroundImage;
  String message;
  String authorName;
  String authorImage;
  List<String> tags;
  String body;
  DateTime timeStamp;

  Article(
      {required this.id,
      required this.type,
      required this.title,
      this.subtitle = '',
      this.backgroundImage = '',
      this.message = '',
      required this.authorName,
      required this.authorImage,
      this.tags = const [],
      this.body = '',
      required this.timeStamp});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] ?? '',
        type: json['type'] ?? '',
        title: json['title'] ?? '',
        subtitle: json['subtitle'] ?? '',
        backgroundImage: json['backgroundImage'] ?? '',
        message: json['message'] ?? '',
        authorName: json['authorName'] ?? '',
        authorImage: json['authorImage'] ?? '',
        tags: json['tags'].cast<String>() ?? [],
        body: json['description'] ?? '',
        timeStamp: DateTime.now());
  }
}
