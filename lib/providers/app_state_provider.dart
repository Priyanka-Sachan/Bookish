import 'package:firebase_auth/firebase_auth.dart';
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
  bool _onboardingComplete = false;
  int _selectedTab = BookishTab.feed;

  bool get isInitialized => !(Firebase.apps.length == 0);

  bool get isOnboardingComplete => _onboardingComplete;

  int get getSelectedTab => _selectedTab;

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  bool isLoggedIn() {
    return auth.currentUser != null;
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
    await auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    bool a = await prefs.clear();
    print('DID PREFERENCES DELETED $a!!!!!!!!111111111111111111');
    notifyListeners();
  }
}
