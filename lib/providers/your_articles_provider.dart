import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

class YourArticlesProvider with ChangeNotifier {
  final _yourArticles = <YourArticle>[];

  List<YourArticle> get yourArticles => List.unmodifiable(_yourArticles);

  void deleteItem(String id) {
    int index = _yourArticles.indexWhere((element) => element.article.id == id);
    _yourArticles.removeAt(index);
    notifyListeners();
  }

  void addItem(YourArticle item) {
    _yourArticles.add(item);
    notifyListeners();
  }

  void updateItem(String id, YourArticle newItem) {
    int index = _yourArticles.indexWhere((element) => element.article.id == id);
    _yourArticles[index] = newItem;
    notifyListeners();
  }

  void uploadItem(String id) {
    int index = _yourArticles.indexWhere((element) => element.article.id == id);
    _yourArticles[index].isUploaded = true;
    notifyListeners();
  }
}
