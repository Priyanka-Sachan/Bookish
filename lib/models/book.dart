class Book {
  int id;
  String image;
  String title;
  String author;
  List<String> bookShelves;
  String path;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.bookShelves,
      required this.path});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] ?? -1,
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        author: json['author'] ?? '',
        bookShelves: json['bookShelves'] != null
            ? json['bookShelves'].toString().split('|')
            : [],
        path: json['path']);
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'author': author,
        'bookShelves': bookShelves.isNotEmpty ? bookShelves.join('|') : null,
        'path': path
      };
}
