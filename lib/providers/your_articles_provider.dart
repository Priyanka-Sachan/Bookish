import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

class YourArticlesProvider with ChangeNotifier {
  final _yourArticles = <YourArticle>[];

  List<YourArticle> get yourArticles => List.unmodifiable(_yourArticles);

  bool _createNewItem = false;
  String _selectedId = '';

  bool get isCreatingNewItem => _createNewItem;

  String get selectedId => _selectedId;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  YourArticle getSelectedItem() {
    YourArticle yourArticle = _yourArticles
        .firstWhere((element) => element.article.id == _selectedId);
    return yourArticle;
  }

  void tapItem(String id) {
    _selectedId = id;
    _createNewItem = false;
    notifyListeners();
  }

  //
  // void completeItem(int index, bool change) {
  //   final item = _yourArticles[index];
  //   _yourArticles[index] = item.copyWith(isComplete: change);
  //   notifyListeners();
  // }

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
