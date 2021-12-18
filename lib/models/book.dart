class Book {
  String id;
  String image;
  String title;
  String description;
  String author;

  Book({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
    );
  }
}