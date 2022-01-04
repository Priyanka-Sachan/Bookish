import 'package:bookish/models/article.dart';
import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/widgets/editorial_card.dart';
import 'package:bookish/widgets/review_card.dart';
import 'package:bookish/widgets/special_card.dart';
import 'package:bookish/widgets/story_card.dart';
import 'package:bookish/widgets/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourArticlesScreen extends StatefulWidget {
  YourArticlesScreen({Key? key}) : super(key: key);

  @override
  State<YourArticlesScreen> createState() => _YourArticlesScreenState();
}

class _YourArticlesScreenState extends State<YourArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YourArticlesProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<YourArticlesProvider>(context, listen: false)
                .createNewItem();
          },
          child: Icon(Icons.add)),
      body: StreamBuilder<List<YourArticle>>(
          stream: provider.watchAllArticles(),
          builder: (context, AsyncSnapshot<List<YourArticle>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final yourArticles = snapshot.data ?? [];
              if (yourArticles.isEmpty) {
                return Center(
                  child: Column(children: [
                    Image.asset('assets/images/add_article.png'),
                    Text(
                      'No articles here...',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ]),
                );
              } else {
                final uploadedArticles =
                    yourArticles.where((e) => e.isUploaded).toList();
                final inProgressArticles =
                    yourArticles.where((e) => !e.isUploaded).toList();
                return ListView(
                  children: [
                    uploadedArticles.isNotEmpty
                        ? Text('Uploaded articles',
                            style: Theme.of(context).textTheme.headline3)
                        : SizedBox(),
                    ...uploadedArticles
                        .map((yourArticle) => articleCard(yourArticle))
                        .toList(),
                    inProgressArticles.isNotEmpty
                        ? Text('In Progress articles',
                            style: Theme.of(context).textTheme.headline3)
                        : SizedBox(),
                    ...inProgressArticles
                        .map((yourArticle) => articleCard(yourArticle))
                        .toList(),
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget articleCard(YourArticle yourArticle) {
    return GestureDetector(
        onTap: () {
          Provider.of<YourArticlesProvider>(context, listen: false)
              .tapItem(yourArticle);
        },
        child: (yourArticle.article.type == ArticleType.editorial)
            ? EditorialCard(article: yourArticle.article)
            : ((yourArticle.article.type == ArticleType.review)
                ? ReviewCard(article: yourArticle.article)
                : ((yourArticle.article.type == ArticleType.upcoming)
                    ? UpcomingCard(article: yourArticle.article)
                    : ((yourArticle.article.type == ArticleType.special)
                        ? SpecialCard(article: yourArticle.article)
                        : ((yourArticle.article.type == ArticleType.story)
                            ? StoryCard(article: yourArticle.article)
                            : SizedBox())))));
  }
}
