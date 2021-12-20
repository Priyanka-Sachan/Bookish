import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/screens/add_article_screen.dart';
import 'package:bookish/widgets/your_article_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class YourArticlesScreen extends StatefulWidget {
  YourArticlesScreen({Key? key}) : super(key: key);

  @override
  State<YourArticlesScreen> createState() => _YourArticlesScreenState();
}

class _YourArticlesScreenState extends State<YourArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final manager =
                Provider.of<YourArticlesProvider>(context, listen: false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddArticleScreen(
                  onCreate: (item) {
                    manager.addItem(item);
                  },
                  onUpdate: (id,item) {
                    manager.updateItem(id, item);
                  },
                  onUpload: (id) {
                    manager.uploadItem(id);
                  },
                ),
              ),
            );
          },
          child: Icon(Icons.add)),
      body: Consumer<YourArticlesProvider>(builder: (ctx, provider, child) {
        if (provider.yourArticles.isEmpty) {
          return Column(children: [
            SvgPicture.asset('assets/images/add_article.svg'),
            Text('No articles here...')
          ]);
        } else {
          final uploadedArticles =
              provider.yourArticles.where((e) => e.isUploaded).toList();
          final inProgressArticles =
              provider.yourArticles.where((e) => !e.isUploaded).toList();
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
      }),
    );
  }
}
