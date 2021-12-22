import 'package:bookish/api/mock_book_service.dart';
import 'package:bookish/models/book.dart';
import 'package:bookish/network/book_model.dart';
import 'package:bookish/widgets/book_thumbnail.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  final mockBookService = MockBookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: mockBookService.getBooks(),
          builder: (context, AsyncSnapshot<List<APIBook>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<APIBook> books=[];
              if(snapshot.hasError) {
                print('LISTEN!!!!!!!!!!!!!!!');
                print(snapshot);
              }
              if(snapshot.hasData)
                books = snapshot.data!;
              return GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (ctx,i) {
                  return BookThumbnail(book: books[i]);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
