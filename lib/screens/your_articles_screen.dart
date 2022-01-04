import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/widgets/your_article_section.dart';
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
                return Column(children: [
                  Image.asset('assets/images/add_article.png'),
                  Text('No articles here...')
                ]);
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
                    YourArticleSection(yourArticles: uploadedArticles),
                    inProgressArticles.isNotEmpty
                        ? Text('In Progress articles',
                            style: Theme.of(context).textTheme.headline3)
                        : SizedBox(),
                    YourArticleSection(yourArticles: inProgressArticles),
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
