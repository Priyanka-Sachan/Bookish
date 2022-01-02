import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookProvider with ChangeNotifier {
  Future<Response<dynamic>> downloadBook(String bookName, String url) async {
    bookName = bookName.replaceAll(' ', '_');
    var tempDir = await getExternalStorageDirectory();
    String fullPath = '${tempDir?.path}/$bookName.epub';
    print('Saved at $fullPath');
    var dio = Dio();
    return dio.download(url, fullPath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    });
  }
}
