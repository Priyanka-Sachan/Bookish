import 'package:bookish/models/article.dart';
import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/screens/add_article_screen.dart';
import 'package:bookish/widgets/editorial_card.dart';
import 'package:bookish/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourArticleSection extends StatelessWidget {
  final List<YourArticle> yourArticles;

  YourArticleSection({required this.yourArticles});

  @override
  Widget build(BuildContext context) {
    return yourArticles.isNotEmpty
        ? Container(
            height: 400,
            child: ListView.builder(
              primary: false,
              itemCount: yourArticles.length,
              itemExtent: MediaQuery.of(context).size.width,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) {
                return GestureDetector(
                    onTap: () {
                      final manager = Provider.of<YourArticlesProvider>(context,
                          listen: false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddArticleScreen(
                            onCreate: (item) {
                              manager.addItem(item);
                            },
                            onUpdate: (item) {
                              manager.updateItem(item, i);
                            },
                            onUpload: (item) {
                              manager.uploadItem(item);
                            },
                            originalItem: yourArticles[i],
                          ),
                        ),
                      );
                    },
                    child: (yourArticles[i].article.type ==
                            ArticleType.editorial)
                        ? EditorialCard(article: yourArticles[i].article)
                        : ((yourArticles[i].article.type == ArticleType.review)
                            ? ReviewCard(article: yourArticles[i].article)
                            : (yourArticles[i].article.type ==
                                    ArticleType.upcoming)
                                ? EditorialCard(
                                    article: yourArticles[i].article)
                                : SizedBox()));
              },
            ),
          )
        : SizedBox();
  }
}
