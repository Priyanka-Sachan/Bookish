import 'package:bookish/models/book.dart';
import 'package:bookish/navigation/navigation_service.dart';
import 'package:bookish/providers/book_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
  double progress = 0;
  bool _isDownloading = true;
  bool _initState = false;
  String hasError = '';
  CancelToken cancelToken = CancelToken();

  void downloadBook(Book book, String url) async {
    String bookName = DateTime.now().millisecondsSinceEpoch.toString();
    var tempDir = await getExternalStorageDirectory();
    String fullPath = '${tempDir?.path}/$bookName.epub';
    book.path = fullPath;
    print('Saved at $fullPath');
    try {
      var dio = Dio();
      await dio.download(url, fullPath, cancelToken: cancelToken,
          onReceiveProgress: (received, total) async {
        if (total != -1) {
          if (mounted) {
            setState(() {
              progress = received / total;
            });
          }
          print((progress * 100).toStringAsFixed(0) + "%");
        }
      });
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
      await Provider.of<BookProvider>(
              NavigationService.navigatorKey.currentContext!,
              listen: false)
          .insertBook(book);
    } catch (e) {
      hasError = 'ERROR: $e';
    }
  }

  @override
  void didChangeDependencies() {
    if (!_initState) {
      downloadBook(widget.book, widget.url);
      _initState = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Downloading '${widget.book.title}.epub'"),
        content: _isDownloading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      cancelToken.cancel();
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Text('CANCEL'),
                  )
                ],
              )
            : hasError.isEmpty
                ? Text('Download Complete! \nRead and Enjoy!!')
                : Text('An unexpected error occurred!! \nTry again later.'));
  }
}
