import 'package:bookish/screens/chat_screen.dart';
import 'package:bookish/screens/explore_screen.dart';
import 'package:bookish/screens/feed_screen.dart';
import 'package:bookish/theme.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    const FeedScreen(),
    const ExploreScreen(),
    const ChatScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = BookishTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Bookish',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bookish', style: Theme.of(context).textTheme.headline6),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Feed',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.library_books_rounded),
              label: 'Explore',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
