import 'package:bookish/network/book_model.dart';
import 'package:bookish/screens/book_details_screen.dart';
import 'package:flutter/material.dart';

class BookThumbnail extends StatelessWidget {
  final APIBook book;

  const BookThumbnail({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(
              book: book,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    '${book.formats['image/jpeg'] != null ? book.formats['image/jpeg']?.replaceAll('small', 'medium') : 'https://i.pinimg.com/736x/a6/50/cd/a650cdc389e72a5213be5f05a8fcd9db.jpg'}',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 150,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Column(
                      children: [
                        Text(
                          book.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.black),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.authors != null && book.authors!.isNotEmpty
                              ? book.authors![0].name.split(',').length > 1
                                  ? ('${book.authors![0].name.split(',')[1]} ${book.authors![0].name.split(',')[0]}')
                                  : book.authors![0].name
                              : 'Anonymous',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.black,
                            ),
                            Text(
                              book.downloadCount != 0
                                  ? book.downloadCount.toString()
                                  : '--',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              ' |',
                              style: TextStyle(color: Colors.black),
                            ),
                            ...book.languages.map((l) => Text(
                                  ' ${l.toUpperCase()}',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.center,
                          children: [
                            ...book.bookshelves.map(
                              (bk) => ChoiceChip(
                                padding: EdgeInsets.zero,
                                label: Text(bk),
                                shape: StadiumBorder(side: BorderSide()),
                                labelStyle: TextStyle(color: Colors.black),
                                selected: true,
                                selectedColor: Colors.white,
                                onSelected: (_) {},
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
