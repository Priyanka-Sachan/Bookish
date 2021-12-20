import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

class YourArticlesProvider with ChangeNotifier {

  final _yourArticles = <YourArticle>[];

  List<YourArticle> get yourArticles => List.unmodifiable(_yourArticles);

  void deleteItem(int index) {
    _yourArticles.removeAt(index);
    notifyListeners();
  }

  void addItem(YourArticle item) {
    _yourArticles.add(item);
    notifyListeners();
  }

  void updateItem(YourArticle item, int index) {
    _yourArticles[index] = item;
    notifyListeners();
  }

  void uploadItem(YourArticle item) {
    int index=_yourArticles.indexOf(item);
    _yourArticles[index].isUploaded = true;
    notifyListeners();
  }
}
