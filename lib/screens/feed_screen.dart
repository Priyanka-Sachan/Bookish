import 'package:bookish/widgets/editorial_card.dart';
import 'package:bookish/widgets/genre_card.dart';
import 'package:bookish/widgets/review_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 450,
        child: ListView(
          itemExtent: MediaQuery.of(context).size.width,
          scrollDirection: Axis.horizontal,
          children: [ReviewCard(), EditorialCard(), GenreCard()],
        ),
      ),
    );
  }
}
