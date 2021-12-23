import 'package:bookish/models/article.dart';
import 'package:bookish/models/bookish_pages.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  static MaterialPage page({required Article article}) {
    return MaterialPage(
      name: BookishPages.articleDetailsPath,
      key: ValueKey(BookishPages.articleDetailsPath),
      child: ArticleDetailsScreen(
        article: article,
      ),
    );
  }

  const ArticleDetailsScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(article.title),
    );
  }
}
