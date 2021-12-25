import 'package:bookish/database/database_helper.dart';
import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

class YourArticlesProvider with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  bool _createNewItem = false;
  bool _updatingItem = false;
  YourArticle? _selectedArticle;

  bool get isCreatingNewItem => _createNewItem;

  bool get updatingItem => _updatingItem;

  YourArticle? get selectedArticle => _selectedArticle;

  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void updateItem() {
    _updatingItem = true;
    notifyListeners();
  }

  void tapItem(YourArticle? yourArticle) {
    _selectedArticle = yourArticle;
    _createNewItem = false;
    _updatingItem=false;
    notifyListeners();
  }

  Future<int> deleteArticle(int id) {
    return dbHelper.deleteArticle(id);
  }

  Future<List<YourArticle>> findAllArticles() {
    return dbHelper.findAllArticles();
  }

  Future<YourArticle> findArticleById(int id) {
    return dbHelper.findArticleById(id);
  }

  Future<int> insertArticle(YourArticle yourArticle) {
    return dbHelper.insertArticle(yourArticle);
  }

  Future<int> updateArticle(YourArticle yourArticle) {
    return dbHelper.updateArticle(yourArticle);
  }

  Stream<List<YourArticle>> watchAllArticles() {
    return dbHelper.watchAllArticles();
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }
}
