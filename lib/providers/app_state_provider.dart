import 'dart:async';

import 'package:flutter/material.dart';

class BookishTab {
  static const int feed = 0;
  static const int explore = 1;
  static const int chat = 2;
  static const int yourArticles = 3;
}

class AppStateProvider with ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = BookishTab.feed;

  bool get isInitialized => _initialized;

  bool get isLoggedIn => _loggedIn;

  bool get isOnboardingComplete => _onboardingComplete;

  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    //In case of firebase or other services, they are started only after all widgets/app is initialized.
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void login(String username, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }
}
