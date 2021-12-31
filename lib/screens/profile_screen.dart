import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/models/user.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/widgets/ProfileImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen({Key? key, required this.user}) : super(key: key);

  static MaterialPage page(User user) {
    return MaterialPage(
      name: BookishPages.profilePath,
      key: ValueKey(BookishPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _editingUsername = false;

  void saveImage(String imageUrl) {
    Provider.of<ProfileProvider>(context, listen: false)
        .updatePhotoUrl(imageUrl);
  }

  @override
  void initState() {
    _usernameController.text = widget.user.username;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileProvider>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            ProfileImagePicker(
                imageUrl: widget.user.profileImageUrl, saveImage: saveImage),
            _editingUsername
                ? TextFormField(
                    controller: _usernameController,
                    maxLength: 16,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .updateUsername(_usernameController.text);
                          setState(() {
                            _editingUsername = false;
                          });
                        },
                        icon: Icon(
                          Icons.done,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    child: Text(widget.user.username),
                    onTap: () {
                      setState(() {
                        _editingUsername = true;
                      });
                    },
                  ),
            Text(widget.user.emailId),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: widget.user.darkMode,
                      onChanged: (value) {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .setDarkMode(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Log out'),
                    onTap: () {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .tapOnProfile(false);
                      Provider.of<AppStateProvider>(context, listen: false)
                          .logout();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
