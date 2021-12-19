import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ReviewCard extends StatefulWidget {
  final Article article;
  ReviewCard({required this.article});

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

  bool _isFavorite = false;

  void toggleFavourite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
             widget.article.backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.softLight),
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.article.authorImage),
                    radius: 28,
                  ),
                  const SizedBox(width: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.article.message,
                          style: BookishTheme.darkTextTheme.headline5,
                          maxLines: 1,
                          softWrap: true,
                          overflow:TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.article.authorName,
                          style: BookishTheme.darkTextTheme.bodyText1,
                        )
                      ]),
                ]),
                IconButton(
                  icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border),
                  iconSize: 30,
                  color: _isFavorite ? Colors.red[400] : Colors.grey[400],
                  onPressed: toggleFavourite,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(children: [
              Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  widget.article.title,
                  style: BookishTheme.darkTextTheme.headline3,
                ),
              ),
              Positioned(
                bottom: 64,
                left: 16,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    widget.article.type,
                    style: BookishTheme.darkTextTheme.headline3,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
