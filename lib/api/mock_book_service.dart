import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:bookish/models/article.dart';
import 'package:bookish/models/book.dart';
import 'package:bookish/models/post.dart';

class MockBookService {
  // Loads sample json data from file system
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  Future<List<Article>> _getArticles() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString =
        await _loadAsset('assets/sample_data/sample_articles_data.json');
    final Map<String, dynamic> json = jsonDecode(dataString);

    if (json['articles'] != null) {
      final articles = <Article>[];
      json['articles'].forEach((v) {
        articles.add(Article.fromJson(v));
      });
      return articles;
    } else {
      return [];
    }
  }

  Future<List<Post>> _getPosts() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString =
        await _loadAsset('assets/sample_data/sample_posts_data.json');
    final Map<String, dynamic> json = jsonDecode(dataString);

    if (json['posts'] != null) {
      final posts = <Post>[];
      json['posts'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getFeeds() async {
    final articles = await _getArticles();
    final posts = await _getPosts();
    return {'articles': articles, 'posts': posts};
  }

  Future<List<Book>> getBooks() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString =
        await _loadAsset('assets/sample_data/sample_books_data.json');
    final Map<String, dynamic> json = jsonDecode(dataString);

    if (json['books'] != null) {
      final books = <Book>[];
      json['books'].forEach((v) {
        books.add(Book.fromJson(v));
      });
      return books;
    } else {
      return [];
    }
  }
}