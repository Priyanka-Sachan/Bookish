import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Article article;

  const ReviewCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              article.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            article.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          Wrap(
            children: [
              Text(
                DateFormat.yMMMd().format(article.timeStamp).toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                ' BY ',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white60),
              ),
              Text(
                article.authorName.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.fade,
              )
            ],
          ),
        ],
      ),
    );
  }
}
