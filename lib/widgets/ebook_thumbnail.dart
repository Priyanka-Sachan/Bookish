import 'package:bookish/models/book.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:bookish/widgets/ebook_dialog.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EbookThumbnail extends StatelessWidget {
  final Book book;

  const EbookThumbnail({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openEbook() {
      EpubViewer.open(
        book.path,
        // first page will open up if the location value is null
      );
    }

    return GestureDetector(
      onTap: openEbook,
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => EbookDialog(
                  book: book,
                ));
      },
      child: GridTile(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                book.image,
                fit: BoxFit.cover,
                height: 248,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            Text(
              book.title,
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Text(
              book.author,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey),
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
