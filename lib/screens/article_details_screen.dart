import 'package:bookish/models/article.dart';
import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/widgets/comment_card.dart';
import 'package:bookish/widgets/comment_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String id;

  static MaterialPage page({required String id}) {
    return MaterialPage(
      name: BookishPages.articleDetailsPath,
      key: ValueKey(BookishPages.articleDetailsPath),
      child: ArticleDetailsScreen(
        id: id,
      ),
    );
  }

  const ArticleDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  void initState() {
    //..Fetch article from id
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: Provider.of<ArticlesProvider>(context, listen: true)
                .getArticleStream(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Article article = Article.fromSnapshot(snapshot.data!);
                return ListView(
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
                        )),
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
                            )),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                                        shape:
                                            StadiumBorder(side: BorderSide()),
                                        labelStyle:
                                            TextStyle(color: Colors.black),
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
                                    Expanded(
                                      child: Stack(
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
                                              child: Text(
                                                article.message,
                                                softWrap: true,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.format_quote_rounded)
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommentSection(id: article.id, comments: article.comments)
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
