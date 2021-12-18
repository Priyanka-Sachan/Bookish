class Type {
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
  String profileImage;
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
    this.profileImage = '',
    this.tags = const [],
    this.description = '',
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      type: json['cardType'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      backgroundImage: json['backgroundImage'] ?? '',
      backgroundImageSource: json['backgroundImageSource'] ?? '',
      message: json['message'] ?? '',
      authorName: json['authorName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      tags: json['tags'].cast<String>() ?? [],
      description: json['description'] ?? '',
    );
  }
}
