import 'package:flutter/material.dart';

import '../theme.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 300,
        height: 450,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1513001900722-370f803f498d'),
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
                        'https://avatars.githubusercontent.com/u/56231576'),
                    radius: 28,
                  ),
                  const SizedBox(width: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chef,
                          style: BookishTheme.darkTextTheme.headline5,
                        ),
                        Text(
                          title,
                          style: BookishTheme.darkTextTheme.bodyText1,
                        )
                      ]),
                ]),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  iconSize: 30,
                  color: Colors.grey[400],
                  onPressed: () {
                    const snackBar =
                        SnackBar(content: Text('Favorite Pressed'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
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
                  'Recipe',
                  style: BookishTheme.darkTextTheme.headline3,
                ),
              ),
              Positioned(
                bottom: 64,
                left: 16,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Smoothies',
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
