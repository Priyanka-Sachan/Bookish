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
  String backgroundImageSource;
  String message;
  String authorName;
  String authorImage;
  List<String> tags;
  String description;

  Article({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle = '',
    this.backgroundImage = '',
    this.backgroundImageSource = '',
    this.message = '',
    this.authorName = '',
    this.authorImage = '',
    this.tags = const [],
    this.description = '',
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      backgroundImage: json['backgroundImage'] ?? '',
      backgroundImageSource: json['backgroundImageSource'] ?? '',
      message: json['message'] ?? '',
      authorName: json['authorName'] ?? '',
      authorImage: json['authorImage'] ?? '',
      tags: json['tags'].cast<String>() ?? [],
      description: json['description'] ?? '',
    );
  }
}
