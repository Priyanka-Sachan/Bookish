import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditorialCard extends StatelessWidget {
  final Article article;

  EditorialCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Stack(
              children: [
                Image.network(
                  article.backgroundImage,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: null, child: Text('EDITORIAL')),
                        Text(
                          article.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          article.subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'By ${article.authorName} ${DateFormat.yMMMd().format(article.timeStamp)}',
            style: Theme.of(context)
                .textTheme
                .headline6,
          )
        ],
      ),
    );
  }
}
