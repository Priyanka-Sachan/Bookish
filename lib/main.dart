import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_router.dart';

void main() {
  runApp(BookishApp());
}

class BookishApp extends StatefulWidget {
  @override
  _BookishAppState createState() => _BookishAppState();
}

class _BookishAppState extends State<BookishApp> {
  final _appStateProvider = AppStateProvider();
  final _profileProvider = ProfileProvider();
  final _yourArticleProvider = YourArticlesProvider();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateProvider: _appStateProvider,
      profileProvider: _profileProvider,
      yourArticlesProvider: _yourArticleProvider,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateProvider),
        ChangeNotifierProvider(create: (context) => _profileProvider),
        ChangeNotifierProvider(create: (context) => _yourArticleProvider)
      ],
      child: Consumer<ProfileProvider>(builder: (ctx, provider, child) {
        ThemeData theme;
        if (provider.darkMode)
          theme = BookishTheme.dark();
        else
          theme = BookishTheme.light();
        return MaterialApp(
          theme: theme,
          title: 'Bookish',
          home: Router(
            routerDelegate: _appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        );
      }),
    );
  }
}
