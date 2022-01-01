class User {
  static String uidKey = 'uid';
  static String emailIdKey = 'email-id';
  static String usernameKey = 'username';
  static String profileImageUrlKey = 'profile-image-url';
  static String darkModeKey = 'dark-mode';

  String uid;
  String emailId;
  String username;
  String profileImageUrl;
  bool darkMode;

  User({
    required this.uid,
    required this.emailId,
    required this.username,
    required this.profileImageUrl,
    required this.darkMode,
  });
}
