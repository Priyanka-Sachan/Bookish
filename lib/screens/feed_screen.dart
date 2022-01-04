import 'package:bookish/models/article.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/widgets/article_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, ${Provider.of<ProfileProvider>(context, listen: true).user.username}!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'What will you read today ?',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Provider.of<ArticlesProvider>(context, listen: true)
                  .getArticlesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final articles = snapshot.data!.docs
                      .map((e) => Article.fromSnapshot(e))
                      .toList();
                  return ArticleSection(articles: articles);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
