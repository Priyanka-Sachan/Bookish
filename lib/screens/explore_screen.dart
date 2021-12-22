import 'dart:convert';

import 'package:bookish/network/book_model.dart';
import 'package:bookish/network/book_service.dart';
import 'package:bookish/widgets/book_thumbnail.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _nextPage = 1;
  bool _loading = true;
  List<APIBook> _books = [];

  Future<APIBookQuery> getBooksData(int page) async {
    final booksJson = await BookService().getBooks(page);
    final booksMap = json.decode(booksJson);
    final booksQuery = APIBookQuery.fromJson(booksMap);
    return booksQuery;
  }

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (_nextPage != 0 && !_loading) {
          setState(() {
            _loading = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getBooksData(_nextPage),
          builder: (context, AsyncSnapshot<APIBookQuery> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot);
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                );
              }
              _loading = false;
              final query = snapshot.data;
              if (query != null) {
                _books.addAll(query.results);
                _nextPage = query.next != null ? _nextPage + 1 : 0;
              }
              return _buildBookList(context, _books);
            } else {
              if (_books.length == 0)
                return const Center(
                  child: CircularProgressIndicator(),
                );
              else
                return _buildBookList(context, _books);
            }
          }),
    );
  }

  Widget _buildBookList(BuildContext context, List<APIBook> books) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      controller: _scrollController,
      itemCount: _books.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx, i) {
        return BookThumbnail(book: _books[i]);
      },
    );
  }
}
