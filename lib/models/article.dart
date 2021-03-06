import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String username;
  String imageUrl;
  String message;
  DateTime timeStamp;

  Comment(
      {required this.id,
      required this.username,
      required this.imageUrl,
      required this.message,
      required this.timeStamp});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        username: json['username'],
        imageUrl: json['imageUrl'],
        message: json['message'],
        timeStamp: (json['timeStamp'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'imageUrl': imageUrl,
      'message': message,
      'timeStamp':
          Timestamp.fromMicrosecondsSinceEpoch(timeStamp.microsecondsSinceEpoch)
    };
  }
}

class ArticleType {
  static const editorial = 'editorial';
  static const review = 'review';
  static const upcoming = 'upcoming';
  static const special = 'special';
  static const story = 'story';
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
  List<Comment>? comments;

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
      required this.timeStamp,
      this.comments});

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
        body: json['body'] ?? '',
        timeStamp: (json['timeStamp'] as Timestamp).toDate(),
        comments: json['comments'] != null
            ? (json['comments'] as List<dynamic>)
                .map((e) => Comment.fromJson(e))
                .toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'subtitle': subtitle,
      'backgroundImage': backgroundImage,
      'message': message,
      'authorName': authorName,
      'authorImage': authorImage,
      'tags': tags,
      'body': body,
      'timeStamp': Timestamp.fromMicrosecondsSinceEpoch(
          timeStamp.microsecondsSinceEpoch),
    };
  }

  factory Article.fromSnapshot(DocumentSnapshot snapshot) {
    final article = Article.fromJson(snapshot.data() as Map<String, dynamic>);
    return article;
  }
}
