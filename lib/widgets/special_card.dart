import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecialCard extends StatelessWidget {
  final Article article;

  const SpecialCard({Key? key, required this.article}) : super(key: key);

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
                      alignment: Alignment.topRight,
                      color: Colors.white54,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        color: Colors.white,
                        child: Text(
                          'SPECIAL THIS MORNING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.black),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              article.title,
              style: Theme.of(context).textTheme.headline5,
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'by ${article.authorName} on ${DateFormat.yMMMd().format(article.timeStamp)}',
              style: Theme.of(context).textTheme.headline6,
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }
}
