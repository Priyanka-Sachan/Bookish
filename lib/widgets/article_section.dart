import 'package:bookish/models/article.dart';
import 'package:bookish/widgets/editorial_card.dart';
import 'package:bookish/widgets/review_card.dart';
import 'package:flutter/material.dart';

class ArticleSection extends StatelessWidget {

  List<Article> articles = [];
  ArticleSection({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Thoughts of the Day 🧠',
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 16),
        Container(
          height: 400,
          child: ListView.builder(
            primary: false,
            itemCount: articles.length,
            itemExtent: MediaQuery.of(context).size.width,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              if (articles[i].type == ArticleType.editorial) {
                return EditorialCard(article: articles[i]);
              } else if (articles[i].type == ArticleType.review) {
                return ReviewCard(article:articles[i]);
              } else if (articles[i].type == ArticleType.upcoming) {
                return EditorialCard(article: articles[i]);
              } else {
                throw Exception('This card doesn\'t exist yet');
              }
            },
          ),
        )
      ],
    );
  }
}
