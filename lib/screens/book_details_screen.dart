import 'package:bookish/models/book.dart';
import 'package:bookish/network/book_model.dart';
import 'package:bookish/widgets/download_dialog.dart';
import 'package:flutter/material.dart';

import 'explore_genre_screen.dart';

class BookDetailsScreen extends StatefulWidget {
  APIBook book;

  BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  List<String> tags = [];

  void getTags() {
    widget.book.subjects.forEach((s) {
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
    String? image = widget.book.formats['image/jpeg'] != null
        ? widget.book.formats['image/jpeg']?.replaceAll('small', 'medium')
        : 'https://i.pinimg.com/736x/a6/50/cd/a650cdc389e72a5213be5f05a8fcd9db.jpg';
    String author = widget.book.authors != null &&
            widget.book.authors!.isNotEmpty
        ? widget.book.authors![0].name.split(',').length > 1
            ? ('${widget.book.authors![0].name.split(',')[1]} ${widget.book.authors![0].name.split(',')[0]}')
            : widget.book.authors![0].name
        : 'Anonymous';
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
                      '$image',
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
                  widget.book.title,
                  style: Theme.of(context).textTheme.headline3,
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                Text(
                  author,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.grey),
                  softWrap: true,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                ...widget.book.languages.map((l) => Text(' ${l.toUpperCase()}',
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
                Column(
                  children: [
                    Icon(Icons.download),
                    Text(
                      widget.book.downloadCount != 0
                          ? widget.book.downloadCount.toString() + '\nDOWNLOADS'
                          : '--',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                widget.book.formats['application/epub+zip'] != null
                    ? InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Text(
                            'DOWNLOAD NOW',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        onTap: () {
                          print(
                              'DOWNLOAD: ${widget.book.formats['application/epub+zip']}');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DownloadDialog(
                                  book: Book(
                                      id: widget.book.id,
                                      image: image ??
                                          'https://i.pinimg.com/736x/a6/50/cd/a650cdc389e72a5213be5f05a8fcd9db.jpg',
                                      title: widget.book.title,
                                      author: author,
                                      subjects: widget.book.subjects,
                                      bookShelves: widget.book.bookshelves,
                                      path: ''),
                                  url: widget.book
                                          .formats['application/epub+zip'] ??
                                      '',
                                );
                              });
                        },
                      )
                    : SizedBox(),
                SizedBox(
                  height: 8,
                ),
                Icon(
                  Icons.arrow_circle_down,
                  size: 32,
                )
              ],
            ),
            widget.book.bookshelves.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 40, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'If you liked ${widget.book.title}'.toUpperCase(),
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
                              ...widget.book.bookshelves
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
