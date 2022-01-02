import 'package:bookish/database/database_helper.dart';
import 'package:bookish/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  void init(DatabaseHelper databaseHelper) {
    dbHelper = databaseHelper;
  }

  Future<int> deleteBook(int id) {
    return dbHelper.deleteBook(id);
  }

  Future<List<Book>> findAllBooks() {
    return dbHelper.findAllBooks();
  }

  Future<Book> findBookById(int id) {
    return dbHelper.findBookById(id);
  }

  Future<Response<dynamic>> downloadBook(Book book, String url) async {
    String bookName = book.title.replaceAll(' ', '_');
    var tempDir = await getExternalStorageDirectory();
    String fullPath = '${tempDir?.path}/$bookName.epub';
    book.path = fullPath;
    print('Saved at $fullPath');
    await insertBook(book);
    var dio = Dio();
    return dio.download(url, fullPath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    });
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
