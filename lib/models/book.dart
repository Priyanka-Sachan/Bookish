class Book {
  int id;
  String image;
  String title;
  String author;
  List<String> subjects;
  List<String> bookShelves;
  String path;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.subjects,
      required this.bookShelves,
      required this.path});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] ?? -1,
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        author: json['author'] ?? '',
        subjects: json['subjects'].toString().split('|'),
        bookShelves: json['bookShelves'].toString().split('|'),
        path: json['path']);
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'image': image,
        'title': title,
        'author': author,
        'subjects': subjects.join('|'),
        'bookShelves': bookShelves.join('|'),
        'path': path
      };
}
