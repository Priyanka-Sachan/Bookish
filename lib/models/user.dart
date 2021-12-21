class User {
  static String usernameKey = 'username';
  static String profileImageUrlKey = 'profile-image-url';
  static String darkModeKey = 'dark-mode';

  String username;
  String profileImageUrl;
  bool darkMode;

  User({
    required this.username,
    required this.profileImageUrl,
    required this.darkMode,
  });
}
