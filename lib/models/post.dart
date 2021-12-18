class Post {
  String id;
  String profileImageUrl;
  String comment;
  String imageUrl;
  String timestamp;

  Post({
    required this.id,
    required this.profileImageUrl,
    required this.comment,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      comment: json['comment'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
