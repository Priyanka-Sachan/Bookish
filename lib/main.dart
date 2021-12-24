import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'navigation/app_router.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BookishApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class BookishApp extends StatefulWidget {
  @override
  _BookishAppState createState() => _BookishAppState();
}

class _BookishAppState extends State<BookishApp> {
  final _appStateProvider = AppStateProvider();
  final _profileProvider = ProfileProvider();
  final _articlesProvider=ArticlesProvider();
  final _yourArticleProvider = YourArticlesProvider();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateProvider: _appStateProvider,
      profileProvider: _profileProvider,
      articlesProvider:_articlesProvider,
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
        ChangeNotifierProvider(create: (context) => _articlesProvider),
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
