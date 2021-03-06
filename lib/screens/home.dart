import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/screens/read_screen.dart';
import 'package:bookish/screens/explore_screen.dart';
import 'package:bookish/screens/feed_screen.dart';
import 'package:bookish/screens/your_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: BookishPages.home,
      key: ValueKey(BookishPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    FeedScreen(),
    ExploreScreen(),
    ReadScreen(),
    YourArticlesScreen()
  ];

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            profileButton(),
          ],
        ),
        body: IndexedStack(index: widget.currentTab, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: widget.currentTab,
          onTap: (index) {
            Provider.of<AppStateProvider>(context, listen: false)
                .goToTab(index);
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Read',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.border_color_rounded),
              label: 'Recommend',
            ),
          ],
        ),
      );
    });
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
              Provider.of<ProfileProvider>(context, listen: false)
                  .user
                  .profileImageUrl),
        ),
        onTap: () {
          Provider.of<ProfileProvider>(context, listen: false)
              .tapOnProfile(true);
        },
      ),
    );
  }
}
