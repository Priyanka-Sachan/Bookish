import 'package:bookish/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookishTab {
  static const int feed = 0;
  static const int explore = 1;
  static const int chat = 2;
  static const int yourArticles = 3;
}

class AppStateProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool _isInitialized = false;
  bool _onboardingComplete = false;
  int _selectedTab = BookishTab.feed;

  bool get isInitialized => _isInitialized;

  bool get isOnboardingComplete => _onboardingComplete;

  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    _isInitialized = true;
    notifyListeners();
  }

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  void checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('onboarding-completed')) {
      _onboardingComplete = prefs.getBool('onboarding-completed')!;
    }
  }

  void completeOnboarding() async {
    _onboardingComplete = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding-completed', true);
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //TODO: Send exception instead of printing them...
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove(User.darkModeKey);
    // prefs.remove('onboarding-completed');
    bool a = await prefs.clear();
    await auth.signOut();
    notifyListeners();
  }
}
