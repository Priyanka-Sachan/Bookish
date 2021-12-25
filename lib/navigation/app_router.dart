import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/screens/add_article_screen.dart';
import 'package:bookish/screens/article_details_screen.dart';
import 'package:bookish/screens/home.dart';
import 'package:bookish/screens/login_screen.dart';
import 'package:bookish/screens/onboarding_screen.dart';
import 'package:bookish/screens/profile_screen.dart';
import 'package:bookish/screens/splash_screen.dart';
import 'package:bookish/screens/your_article_details_screen.dart';
import 'package:flutter/material.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateProvider appStateProvider;
  final ProfileProvider profileProvider;
  final ArticlesProvider articlesProvider;
  final YourArticlesProvider yourArticlesProvider;

  AppRouter({
    required this.appStateProvider,
    required this.profileProvider,
    required this.articlesProvider,
    required this.yourArticlesProvider,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateProvider.addListener(notifyListeners);
    profileProvider.addListener(notifyListeners);
    articlesProvider.addListener(notifyListeners);
    yourArticlesProvider.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateProvider.removeListener(notifyListeners);
    profileProvider.removeListener(notifyListeners);
    articlesProvider.removeListener(notifyListeners);
    yourArticlesProvider.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateProvider.isInitialized) SplashScreen.page(),
        if (appStateProvider.isInitialized && !appStateProvider.isLoggedIn)
          LoginScreen.page(),
        if (appStateProvider.isLoggedIn &&
            !appStateProvider.isOnboardingComplete)
          OnboardingScreen.page(),
        if (appStateProvider.isOnboardingComplete)
          Home.page(appStateProvider.getSelectedTab),
        if (articlesProvider.selectedId.isNotEmpty)
          ArticleDetailsScreen.page(id: articlesProvider.selectedId),
        if (yourArticlesProvider.isCreatingNewItem)
          AddArticleScreen.page(
              onCreate: (item) {
                yourArticlesProvider.insertArticle(item);
              },
              onUpdate: (item) {},
              originalItem: null),
        if (yourArticlesProvider.selectedArticle != null)
          YourArticleDetailsScreen.page(
            yourArticle: yourArticlesProvider.selectedArticle!,
          ),
        if (yourArticlesProvider.updatingItem)
          AddArticleScreen.page(
            onCreate: (item){},
              onUpdate: (item) {
                yourArticlesProvider.updateArticle(item);
              },
              originalItem: yourArticlesProvider.selectedArticle),
        if (profileProvider.didSelectUser)
          ProfileScreen.page(profileProvider.user),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name == BookishPages.onboardingPath) {
      appStateProvider.logout();
    }
    if (route.settings.name == BookishPages.articleDetailsPath) {
      articlesProvider.tapItem('');
    }
    if (route.settings.name == BookishPages.yourArticleDetailsPath) {
      yourArticlesProvider.tapItem(null);
    }
    if (route.settings.name == BookishPages.addArticlePath) {
      yourArticlesProvider.tapItem(null);
    }
    if (route.settings.name == BookishPages.profilePath) {
      profileProvider.tapOnProfile(false);
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
