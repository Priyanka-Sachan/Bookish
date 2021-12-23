import 'package:bookish/network/genre.dart';
import 'package:bookish/screens/explore_genre_screen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Genre> genres = [
    Genre(name: 'romance', imageUrl: 'assets/images/genre-1.png'),
    Genre(name: 'adventure', imageUrl: 'assets/images/genre-2.png'),
    Genre(name: 'mystery', imageUrl: 'assets/images/genre-3.png'),
    Genre(name: 'biography', imageUrl: 'assets/images/genre-4.png'),
    Genre(name: 'children\'s', imageUrl: 'assets/images/genre-5.png'),
    Genre(name: 'classics', imageUrl: 'assets/images/genre-6.png'),
    Genre(name: 'fantasy', imageUrl: 'assets/images/genre-7.png'),
    Genre(name: 'history', imageUrl: 'assets/images/genre-8.png'),
    Genre(name: 'horror', imageUrl: 'assets/images/genre-9.png'),
    Genre(name: 'literature', imageUrl: 'assets/images/genre-10.png'),
    Genre(name: 'technology', imageUrl: 'assets/images/genre-11.png'),
    Genre(name: 'science fiction', imageUrl: 'assets/images/genre-12.png'),
    Genre(name: 'animal', imageUrl: 'assets/images/genre-13.png'),
    Genre(name: 'countries', imageUrl: 'assets/images/genre-14.png'),
    Genre(name: 'law', imageUrl: 'assets/images/genre-15.png'),
    Genre(name: 'education', imageUrl: 'assets/images/genre-16.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreGenreScreen(
                      genre: '',
                    )),
          );
        },
        child: Icon(Icons.lock_open_rounded),
      ),
      body: ListView.builder(
          itemCount: genres.length,
          itemBuilder: (ctx, i) {
            return _genreCard(context, genres[i]);
          }),
    );
  }

  Widget _genreCard(BuildContext context, Genre genre) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExploreGenreScreen(genre: genre.name)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Stack(
          children: [
            Image.asset(
              genre.imageUrl,
              height: 256,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: Text(
                  genre.name.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
