import 'package:bookish/network/book_model.dart';
import 'package:bookish/network/book_service.dart';
import 'package:bookish/network/model_response.dart';
import 'package:bookish/widgets/book_thumbnail.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

class ExploreGenreScreen extends StatefulWidget {
  String genre;

  ExploreGenreScreen({Key? key, required this.genre}) : super(key: key);

  @override
  State<ExploreGenreScreen> createState() => _ExploreGenreScreenState();
}

class _ExploreGenreScreenState extends State<ExploreGenreScreen> {
  int _nextPage = 1;
  bool _loading = true;
  bool _inErrorState = false;
  List<APIBook> _books = [];
  final _bookService = BookService.create();

  final _scrollController = ScrollController();

  Future<Response<Result<APIBookQuery>>> getBooks() {
    if (widget.genre.isNotEmpty)
      return _bookService.queryBooksByGenre(_nextPage, widget.genre);
    return _bookService.queryBooks(_nextPage);
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (_nextPage != 0 && !_loading && !_inErrorState) {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: getBooks(),
          builder: (context,
              AsyncSnapshot<Response<Result<APIBookQuery>>> snapshot) {
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
              final result = snapshot.data?.body;
              if (result is Error) {
                // Hit an error
                _inErrorState = true;
                return _buildBookList(context, _books);
              }
              final query = (result as Success).value;
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
    return ListView.builder(
      padding: EdgeInsets.all(8),
      controller: _scrollController,
      itemCount: _books.length,
      itemBuilder: (ctx, i) {
        return BookThumbnail(book: _books[i]);
      },
    );
  }
}
