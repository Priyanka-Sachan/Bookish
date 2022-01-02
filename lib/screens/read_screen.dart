import 'package:bookish/models/book.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                return ListView.builder(
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(books[i].image),
                      ),
                      title: Text(books[i].title),
                      subtitle: Text(books[i].author),
                    );
                  },
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
