import 'article.dart';

class YourArticle {
  Article article;
  bool isUploaded;

  YourArticle({required this.article, required this.isUploaded});

  // Create a Recipe from JSON data
  factory YourArticle.fromJson(Map<String, dynamic> json) {
    Article article = Article(
        id: json['id'].toString(),
        type: json['type'] ?? '',
        title: json['title'] ?? '',
        subtitle: json['subtitle'] ?? '',
        backgroundImage: json['backgroundImage'] ?? '',
        message: json['message'] ?? '',
        authorName: json['authorName'] ?? '',
        authorImage: json['authorImage'] ?? '',
        tags: json['tags'].toString().split('|'),
        body: json['body'] ?? '',
        timeStamp: DateTime.parse(json['timeStamp'] as String),
        comments: []);
    return YourArticle(article: article, isUploaded: json['isUploaded'] == 1);
  }

// Convert our Recipe to JSON to make it easier when you store
// it in the database
  Map<String, dynamic> toJson() => {
        'type': article.type,
        'title': article.title,
        'subtitle': article.subtitle,
        'backgroundImage': article.backgroundImage,
        'message': article.message,
        'authorName': article.authorName,
        'authorImage': article.authorImage,
        'tags': article.tags.join('|'),
        'body': article.body,
        'timeStamp': article.timeStamp.toString(),
        'isUploaded': isUploaded ? 1 : 0
      };
}
