import 'package:flutter/material.dart';

import '../theme.dart';

class GenreCard extends StatefulWidget {
  const GenreCard({Key? key}) : super(key: key);

  @override
  _GenreCardState createState() => _GenreCardState();
}

class _GenreCardState extends State<GenreCard> {
  List<String> genres = [
    'Historical',
    'Non-fiction',
    'Autobiography',
    'Fantasy',
    'Supernatural',
    'Young Adult',
    'Romance'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(32),
      constraints: const BoxConstraints.expand(
        width: 300,
        height: 450,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1529473814998-077b4fec6770'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.softLight),
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.book,
            color: Colors.white,
            size: 40,
          ),
          Text('Genre Trends', style: BookishTheme.darkTextTheme.headline3),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 6,
            children: genres
                .map(
                  (e) => Chip(
                    label: Text(e, style: BookishTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      setState(() {
                        genres.remove(e);
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
