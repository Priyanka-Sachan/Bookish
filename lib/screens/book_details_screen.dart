import 'package:bookish/network/book_model.dart';
import 'package:flutter/material.dart';

import 'explore_genre_screen.dart';

class BookDetailsScreen extends StatelessWidget {
  APIBook book;

  BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  List<String> tags = [];

  void getTags() {
    book.subjects.forEach((s) {
      s.split('--').forEach((e) {
        String tag = e.trim().toLowerCase();
        if (tag.length <= 24) tags.add(tag);
      });
    });
    tags = tags.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    getTags();
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            ListView(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Stack(
                  children: [
                    Image.network(
                      '${book.formats['image/jpeg'] != null ? book.formats['image/jpeg']?.replaceAll('small', 'medium') : 'https://i.pinimg.com/736x/a6/50/cd/a650cdc389e72a5213be5f05a8fcd9db.jpg'}',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(color: Colors.black45),
                    )),
                    Positioned(
                        top: 32,
                        left: 8,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ))
                  ],
                ),
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headline3,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Text(
                  book.authors != null && book.authors!.isNotEmpty
                      ? book.authors![0].name.split(',').length > 1
                          ? ('${book.authors![0].name.split(',')[1]} ${book.authors![0].name.split(',')[0]}')
                          : book.authors![0].name
                      : 'Anonymous',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.grey),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                ...book.languages.map((l) => Text(' ${l.toUpperCase()}',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center)),
                Wrap(
                  spacing: 4,
                  alignment: WrapAlignment.center,
                  children: [
                    ...tags.map(
                      (tag) => ChoiceChip(
                        padding: EdgeInsets.zero,
                        label: Text(tag),
                        shape: StadiumBorder(side: BorderSide()),
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        selected: true,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (_) {},
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.download),
                        Text(
                          book.downloadCount != 0
                              ? book.downloadCount.toString() + '\nDOWNLOADS'
                              : '--',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('text/html'.toUpperCase(),
                            semanticsLabel: book.formats['text/html']),
                        Text('text/plain'.toUpperCase(),
                            semanticsLabel: book.formats['text/plain']),
                        Text('application/epub+zip'.toUpperCase(),
                            semanticsLabel:
                                book.formats['application/epub+zip']),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Icon(
                  Icons.arrow_circle_down,
                  size: 32,
                )
              ],
            ),
            book.bookshelves.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 40, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'If you liked ${book.title}'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(wordSpacing: 0.1, letterSpacing: 0.2),
                        ),
                        Text(
                          'You can also checkout these bookshelves..',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.grey),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              ...book.bookshelves
                                  .map((b) => _bookshelfCard(context, b))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _bookshelfCard(BuildContext context, String bookshelf) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExploreGenreScreen(genre: bookshelf)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Stack(
          children: [
            Image.network(
              'https://source.unsplash.com/random/400×200/?history,book,${bookshelf.split(' ')[0]}',
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: Text(
                  bookshelf.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
