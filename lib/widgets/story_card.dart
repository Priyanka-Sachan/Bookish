import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final Article article;

  const StoryCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(color: Colors.black54, width: 2),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BOOKISH DAILY',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
          Divider(
            height: 2,
            color: Colors.grey,
          ),
          Text(
            article.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              article.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            article.subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.fade,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.black54)),
            child: Text(
              'KNOW MORE',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
