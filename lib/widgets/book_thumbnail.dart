import 'package:bookish/models/book.dart';
import 'package:flutter/material.dart';

class BookThumbnail extends StatelessWidget {
  final Book book;

  const BookThumbnail({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.network(
                '${book.image}',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            book.author,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
