import 'package:bookish/network/book_model.dart';
import 'package:flutter/material.dart';

class BookThumbnail extends StatelessWidget {
  final APIBook book;

  const BookThumbnail({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              '${book.formats['image/jpeg'] != null ? book.formats['image/jpeg']?.replaceAll('small', 'medium') : 'https://i.pinimg.com/736x/a6/50/cd/a650cdc389e72a5213be5f05a8fcd9db.jpg'}',
              fit: BoxFit.cover,
              width: 100,
              height: 150,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headline6,
                  softWrap: true,
                ),
                Text(
                  book.authors != null && book.authors!.isNotEmpty
                      ? book.authors![0].name
                      : 'Anonymous',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                  softWrap: true,
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download),
                    Text(book.downloadCount != 0
                        ? book.downloadCount.toString()
                        : '--'),
                    Text('|'),
                    Text(book.languages[0])
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
