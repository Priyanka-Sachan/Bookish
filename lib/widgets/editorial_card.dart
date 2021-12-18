import 'package:flutter/material.dart';

import '../theme.dart';

class EditorialCard extends StatelessWidget {
  const EditorialCard({Key? key}) : super(key: key);

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
                'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.softLight),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Stack(
          children: [
            Text(
              category,
              style: BookishTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
              child: Text(
                title,
                style: BookishTheme.darkTextTheme.headline4,
              ),
              top: 20,
            ),
            Positioned(
              child: Text(
                description,
                style: BookishTheme.darkTextTheme.bodyText1,
              ),
              bottom: 30,
              right: 0,
            ),
            Positioned(
              child: Text(
                chef,
                style: BookishTheme.darkTextTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            ),
          ],
        ),
    );
  }
}
