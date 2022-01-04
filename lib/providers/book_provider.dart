import 'dart:io';

import 'package:bookish/database/database_helper.dart';
import 'package:bookish/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  bool _isDownloading = false;

  bool get isDownloading => _isDownloading;

  void init(DatabaseHelper databaseHelper) {
    dbHelper = databaseHelper;
  }

  void deleteBook(Book book) async {
    await dbHelper.deleteBook(book.id);
    File file = File(book.path);
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('ERROR ON DELETE: $e');
      await dbHelper.insertBook(book);
    }
  }

  Future<List<Book>> findAllBooks() {
    return dbHelper.findAllBooks();
  }

  Future<Book> findBookById(int id) {
    return dbHelper.findBookById(id);
  }

  void downloadBook(Book book, String url) async {
    _isDownloading = true;
    String bookName = DateTime.now().millisecondsSinceEpoch.toString();
    var tempDir = await getExternalStorageDirectory();
    String fullPath = '${tempDir?.path}/$bookName.epub';
    book.path = fullPath;
    print('Saved at $fullPath');
    try {
      var dio = Dio();
      await dio.download(url, fullPath,
          onReceiveProgress: (received, total) async {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      });
      await insertBook(book);
    } catch (e) {
      print('ERROR: $e');
    }
    _isDownloading = false;
  }

  Future<int> insertBook(Book book) {
    return dbHelper.insertBook(book);
  }

  Future<int> updateBook(Book book) {
    return dbHelper.updateBook(book);
  }

  Stream<List<Book>> watchAllBooks() {
    return dbHelper.watchAllBooks();
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }
}
