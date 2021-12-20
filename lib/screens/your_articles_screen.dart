import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/screens/add_article_screen.dart';
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
                      Navigator.pop(context);
                      setState(() {});
                    },
                    onUpdate: (item) {},
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
            return ListView.builder(
                itemCount: provider.yourArticles.length,
                itemBuilder: (ctx, i) {
                  return Text(provider.yourArticles[i].article.title);
                });
          }
        }),
    );
  }
}
