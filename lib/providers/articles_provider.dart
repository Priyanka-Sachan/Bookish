import 'dart:convert';

import 'package:bookish/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArticlesProvider with ChangeNotifier {
  String _selectedId = '';

  String get selectedId => _selectedId;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('articles');

  Stream<QuerySnapshot> getArticlesStream() {
    return collection.snapshots();
  }

  void saveArticle(Article article) {
    collection.add(article.toJson());
  }

  Stream<DocumentSnapshot<Object?>> getArticleStream(String id) {
    return collection.doc(id).snapshots();
  }

  void addComment(String id,Comment comment) {
    //...
  }

  void tapItem(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
