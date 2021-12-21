import 'package:bookish/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  User _user = User(
      username: 'Anonymous',
      profileImageUrl:
          "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=",
      darkMode: false);
  bool _didSelectUser = false;

  User get user => _user;

  bool get darkMode => _user.darkMode;

  bool get didSelectUser => _didSelectUser;

  void fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(User.usernameKey)) {
      String? username = prefs.getString(User.usernameKey);
      _user.username =
          username != null && username.isNotEmpty ? username : 'Anonymous';
    }
    if (prefs.containsKey(User.profileImageUrlKey)) {
      String? profileImageUrl = prefs.getString(User.profileImageUrlKey);
      _user.profileImageUrl = profileImageUrl != null &&
              profileImageUrl.isNotEmpty
          ? profileImageUrl
          : "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=";
    }
    if (prefs.containsKey(User.darkModeKey)) {
      _user.darkMode = prefs.getBool(User.darkModeKey)!;
    }
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }

  set darkMode(bool darkMode) {
    _user.darkMode = darkMode;
    //TODO: Update preferences.
    notifyListeners();
  }
}
