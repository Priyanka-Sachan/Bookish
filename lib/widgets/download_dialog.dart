import 'package:bookish/models/book.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadDialog extends StatefulWidget {
  final Book book;
  final String url;

  const DownloadDialog({Key? key, required this.book, required this.url})
      : super(key: key);

  @override
  _DownloadDialogState createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Downloading '${widget.book.title}.epub'"),
      content: FutureBuilder(
          future: Provider.of<BookProvider>(context, listen: true)
              .downloadBook(widget.book, widget.url),
          builder: (context, AsyncSnapshot<Response<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('An unknown error occurred.');
              } else
                return Text('Downloaded Successfully!');
            } else {
              return LinearProgressIndicator();
            }
          }),
    );
  }
}
