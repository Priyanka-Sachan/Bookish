import 'package:bookish/models/user.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  User _user =
      User(username: 'Anonymous', profileImageUrl: '...', darkMode: false);

  User get user => _user;

  set darkMode(bool darkMode) {
    _user.darkMode = darkMode;
    notifyListeners();
  }

  void fetchUser() {
    _user = User(
        username: 'Known User',
        profileImageUrl:
            "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=",
        darkMode: false);
    notifyListeners();
  }
}
