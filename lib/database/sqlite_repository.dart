import 'dart:async';
import 'package:bookish/database/repository.dart';
import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

import 'database_helper.dart';

class SqliteRepository extends Repository with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<int> deleteArticle(int id) {
    // TODO: implement deleteArticle
    throw UnimplementedError();
  }

  @override
  Future<List<YourArticle>> findAllArticles() {
    // TODO: implement findAllArticles
    throw UnimplementedError();
  }

  @override
  Future<YourArticle> findArticleById(int id) {
    // TODO: implement findArticleById
    throw UnimplementedError();
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<int> insertArticle(YourArticle article) {
    // TODO: implement insertArticle
    throw UnimplementedError();
  }

  @override
  Future<int> updateArticle(YourArticle yourArticle) {
    // TODO: implement updateArticle
    throw UnimplementedError();
  }

  @override
  Stream<List<YourArticle>> watchAllArticles() {
    // TODO: implement watchAllArticles
    throw UnimplementedError();
  }
}
