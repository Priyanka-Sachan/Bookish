import 'package:bookish/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  User _user = User(
      uid: '',
      emailId: '',
      username: 'Anonymous',
      profileImageUrl:
          "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=",
      darkMode: false);
  bool _didSelectUser = false;

  User get user => _user;

  bool get darkMode => _user.darkMode;

  bool get didSelectUser => _didSelectUser;

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }

  Future<void> setDarkMode(bool darkMode) async {
    _user.darkMode = darkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(User.darkModeKey, darkMode);
    notifyListeners();
  }

  void fetchUser() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      _user.uid = currentUser.uid;
      _user.emailId = currentUser.email ?? '';
      _user.username = currentUser.displayName ??
          _user.emailId.replaceRange(
              _user.emailId.indexOf('@'), _user.emailId.length, '');
      _user.profileImageUrl = currentUser.photoURL ??
          "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=";
    }
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(User.darkModeKey)) {
      _user.darkMode = prefs.getBool(User.darkModeKey)!;
    }
    notifyListeners();
  }

  Future<void> updateUsername(String username) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(username);
    _user.username=username;
    notifyListeners();
  }

  Future<void> updatePhotoUrl(String photoUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(photoUrl);
    _user.profileImageUrl=photoUrl;
    notifyListeners();
  }
}
