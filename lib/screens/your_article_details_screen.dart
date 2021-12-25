import 'package:bookish/models/article.dart';
import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YourArticleDetailsScreen extends StatefulWidget {
  final YourArticle yourArticle;

  static MaterialPage page({required YourArticle yourArticle}) {
    return MaterialPage(
      name: BookishPages.yourArticleDetailsPath,
      key: ValueKey(BookishPages.yourArticleDetailsPath),
      child: YourArticleDetailsScreen(
        yourArticle: yourArticle,
      ),
    );
  }

  const YourArticleDetailsScreen({Key? key, required this.yourArticle})
      : super(key: key);

  @override
  State<YourArticleDetailsScreen> createState() =>
      _YourArticleDetailsScreenState();
}

class _YourArticleDetailsScreenState extends State<YourArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Article article = widget.yourArticle.article;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Image.network(article.backgroundImage,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black45),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 8,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Positioned(
                  top: 32,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                     Provider.of<YourArticlesProvider>(context,listen: false).updateItem();
                    },
                  ),
                ),
                Positioned(
                  top: 32,
                  right: 48,
                  child: IconButton(
                    icon: Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //TODO: ...
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(16, 250, 16, 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMd()
                              .format(article.timeStamp)
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        Text(
                          article.title,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          article.subtitle,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          article.body,
                        ),
                        Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.center,
                          children: [
                            ...article.tags.map(
                              (tag) => ChoiceChip(
                                padding: EdgeInsets.zero,
                                label: Text(tag),
                                shape: StadiumBorder(side: BorderSide()),
                                labelStyle: TextStyle(color: Colors.black),
                                selected: true,
                                selectedColor: Colors.transparent,
                                onSelected: (_) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(article.authorImage),
                                  radius: 32,
                                ),
                                Text(article.authorName)
                              ],
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text(article.message)),
                                ),
                                Icon(Icons.format_quote_rounded)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
