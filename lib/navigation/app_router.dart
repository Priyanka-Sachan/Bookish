import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:bookish/screens/add_article_screen.dart';
import 'package:bookish/screens/home.dart';
import 'package:bookish/screens/login_screen.dart';
import 'package:bookish/screens/onboarding_screen.dart';
import 'package:bookish/screens/profile_screen.dart';
import 'package:bookish/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateProvider appStateProvider;
  final ProfileProvider profileProvider;
  final YourArticlesProvider yourArticlesProvider;

  AppRouter({
    required this.appStateProvider,
    required this.profileProvider,
    required this.yourArticlesProvider,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateProvider.addListener(notifyListeners);
    profileProvider.addListener(notifyListeners);
    yourArticlesProvider.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateProvider.removeListener(notifyListeners);
    profileProvider.removeListener(notifyListeners);
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
        if (yourArticlesProvider.isCreatingNewItem)
          AddArticleScreen.page(
              onCreate: (item) {
                yourArticlesProvider.addItem(item);
              },
              onUpdate: (item, id) {
                yourArticlesProvider.updateItem(item, id);
              },
              onUpload: (id) {
                yourArticlesProvider.uploadItem(id);
              }),
        if (yourArticlesProvider.selectedId.isNotEmpty)
          AddArticleScreen.page(
              originalItem: yourArticlesProvider.getSelectedItem(),
              onCreate: (item) {},
              onUpdate: (item, id) {
                yourArticlesProvider.updateItem(item, id);
              },
              onUpload: (id) {
                yourArticlesProvider.uploadItem(id);
              }),
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
    if (route.settings.name == BookishPages.addArticlePath) {
      yourArticlesProvider.tapItem('');
    }
    if (route.settings.name == BookishPages.profilePath) {
      profileProvider.tapOnProfile(false);
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
