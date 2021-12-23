import 'dart:convert';

import 'package:bookish/models/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ArticlesProvider with ChangeNotifier {
  List<Article> _articles = <Article>[];

  List<Article> get articles => List.unmodifiable(_articles);

  String _selectedId = '';

  String get selectedId => _selectedId;

  Future<List<Article>> fetchArticles() async {
    final dataString = await rootBundle
        .loadString('assets/sample_data/sample_articles_data.json');
    final Map<String, dynamic> json = jsonDecode(dataString);
    List<Article> results = <Article>[];
    if (json['articles'] != null) {
      json['articles'].forEach((v) {
        results.add(Article.fromJson(v));
      });
      _articles = results;
      return _articles;
    } else {
      return [];
    }
  }

  Article getSelectedItem() {
    Article article =
        _articles.firstWhere((element) => element.id == _selectedId);
    return article;
  }

  void tapItem(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
