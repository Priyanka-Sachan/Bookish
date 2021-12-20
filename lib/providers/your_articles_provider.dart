import 'package:bookish/models/article.dart';
import 'package:bookish/models/your_article.dart';
import 'package:flutter/cupertino.dart';

class YourArticlesProvider with ChangeNotifier {
  // static Article a = Article(
  //     id: '455v',
  //     type: 'review',
  //     title: 'title',
  //     subtitle: 'subtitle',
  //     backgroundImage: '',
  //     message: 'message!!!',
  //     authorName: 'anonymous',
  //     authorImage: '',
  //     tags: ['new', 'fiction'],
  //     body: 'body heree!!!!1111',
  //     timeStamp: DateTime.now());
  // static YourArticle yourArticle = YourArticle(article: a, isUploaded: false);

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

  void uploadItem(int index) {
    _yourArticles[index].isUploaded = true;
    notifyListeners();
  }
}
