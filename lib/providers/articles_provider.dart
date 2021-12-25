import 'package:bookish/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticlesProvider with ChangeNotifier {
  String _selectedId = '';

  String get selectedId => _selectedId;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('articles');

  Stream<QuerySnapshot> getArticlesStream() {
    return collection.snapshots();
  }

  void saveArticle(String userId, Article article) {
    var articleJson = article.toJson();
    articleJson['id'] = '$userId@${articleJson['id']}';
    collection.doc(articleJson['id']).set(articleJson);
  }

  Stream<DocumentSnapshot<Object?>> getArticleStream(String id) {
    return collection.doc(id).snapshots();
  }

  void addComment(String id, Comment comment) {
    //...
    collection.doc(id).collection('comments').add(comment.toJson());
  }

  void tapItem(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
