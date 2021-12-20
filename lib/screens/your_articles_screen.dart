import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class YourArticlesScreen extends StatelessWidget {
  YourArticlesScreen({Key? key}) : super(key: key);
  final List<YourArticle> articles = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<YourArticlesProvider>(builder: (ctx, provider, child) {
      return Scaffold(
        body: provider.yourArticles.length == 0
            ? Column(children: [
                SvgPicture.asset('assets/images/add_article.svg'),
                ElevatedButton(onPressed: () {}, child: Text('ADD ARTICLE'))
              ])
            : Text('HERE ARE YOUR ARTICLES!!!'),
      );
    });
  }
}
