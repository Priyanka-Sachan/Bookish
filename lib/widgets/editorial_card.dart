import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class EditorialCard extends StatelessWidget {
  final Article article;

  EditorialCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              article.backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.softLight),
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Stack(
        children: [
          Text(
            article.type,
            style: BookishTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            child: Text(
              article.title,
              style: BookishTheme.darkTextTheme.headline4,
            ),
            top: 20,
          ),
          Positioned(
            child: Text(
              article.message,
              style: BookishTheme.darkTextTheme.bodyText1,
            ),
            bottom: 30,
            right: 0,
          ),
          Positioned(
            child: Text(
              article.authorName,
              style: BookishTheme.darkTextTheme.bodyText1,
            ),
            bottom: 10,
            right: 0,
          ),
        ],),
    );
  }
}
