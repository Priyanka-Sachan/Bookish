import 'package:bookish/models/book.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EbookDialog extends StatelessWidget {
  final Book book;

  const EbookDialog({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openEbook() {
      EpubViewer.open(
        book.path,
        // first page will open up if the location value is null
      );
    }

    void deleteEbook() {
      Provider.of<BookProvider>(context, listen: false).deleteBook(book);
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }

    void updateEbook() {
      Provider.of<BookProvider>(context, listen: false).updateBook(book);
    }

    return SimpleDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            book.author,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              book.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        TextFieldTags(
            initialTags: book.bookShelves,
            textSeparators: [","],
            textFieldStyler: TextFieldStyler(
                hintText: 'Add to bookshelf',
                helperText: '',
                helperStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                textFieldBorder: InputBorder.none,
                textFieldFocusedBorder: InputBorder.none,
                textFieldDisabledBorder: InputBorder.none,
                textFieldEnabledBorder: InputBorder.none),
            tagsStyler: TagsStyler(
                tagPadding: const EdgeInsets.all(8.0),
                tagDecoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(8))),
                tagCancelIcon:
                    const Icon(Icons.cancel, size: 18.0, color: Colors.grey)),
            onTag: (tag) {
              book.bookShelves.add(tag);
              updateEbook();
            },
            onDelete: (tag) {
              updateEbook();
              book.bookShelves.remove(tag);
            },
            validator: (tag) {
              if (tag.length > 32) {
                return "Hey that's too long";
              }
              if (book.bookShelves.contains(tag)) {
                return "Bookshelf already added";
              }
              return null;
            }),
        ListTile(
          title: Text('Read'),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            openEbook();
          },
        ),
        ListTile(
          title: Text('Delete'),
          onTap: deleteEbook,
        ),
      ],
    );
  }
}
