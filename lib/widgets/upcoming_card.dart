import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';

class UpcomingCard extends StatelessWidget {
  final Article article;

  UpcomingCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            article.title,
            style: Theme.of(context).textTheme.headline5,
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
          OutlinedButton(onPressed: null, child: Text('KNOW MORE'))
        ],
      ),
    );
  }
}
