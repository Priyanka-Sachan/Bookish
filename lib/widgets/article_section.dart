import 'package:bookish/models/article.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/widgets/editorial_card.dart';
import 'package:bookish/widgets/review_card.dart';
import 'package:bookish/widgets/special_card.dart';
import 'package:bookish/widgets/story_card.dart';
import 'package:bookish/widgets/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleSection extends StatelessWidget {
  final List<Article> articles;

  ArticleSection({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //Important 3 lines for nested lists
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
            onTap: () {
              Provider.of<ArticlesProvider>(context, listen: false)
                  .tapItem(articles[i].id);
            },
            child: (articles[i].type == ArticleType.editorial)
                ? EditorialCard(article: articles[i])
                : ((articles[i].type == ArticleType.review)
                    ? ReviewCard(article: articles[i])
                    : ((articles[i].type == ArticleType.upcoming)
                        ? UpcomingCard(article: articles[i])
                        : ((articles[i].type == ArticleType.special)
                            ? SpecialCard(article: articles[i])
                            : ((articles[i].type == ArticleType.story)
                                ? StoryCard(article: articles[i])
                                : SizedBox())))));
      },
    );
  }
}
