import 'package:bookish/models/book.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EpubViewer.setConfig(
      themeColor: Theme.of(context).colorScheme.primary,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.VERTICAL,
      allowSharing: true,
      enableTts: true,
    );
    final provider = Provider.of<BookProvider>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<List<Book>>(
          stream: provider.watchAllBooks(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final books = snapshot.data ?? [];
              if (books.isEmpty) {
                return Column(children: [
                  SvgPicture.asset('assets/images/add_article.svg'),
                  Text('No books here...')
                ]);
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: 300,
                    ),
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          EpubViewer.open(
                            books[i].path,
                            // first page will open up if the location value is null
                          );
                        },
                        child: GridTile(
                          child: Column(
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  books[i].image,
                                  fit: BoxFit.cover,
                                  height: 250,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              Text(
                                books[i].title,
                                style: Theme.of(context).textTheme.bodyText2,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                books[i].author,
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
                    },
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
