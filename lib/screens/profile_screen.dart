import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/models/user.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/theme.dart';
import 'package:bookish/widgets/profile_image_picker.dart';
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
    return Theme(
      data: BookishTheme.light().copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.black,
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                  ? IntrinsicWidth(
                      child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () {
                              Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .updateUsername(_usernameController.text);
                              setState(() {
                                _editingUsername = false;
                              });
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      child: Text(
                        widget.user.username,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      onTap: () {
                        setState(() {
                          _editingUsername = true;
                        });
                      },
                    ),
              Text(
                widget.user.emailId,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.black),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text(
                        'Dark Mode',
                      ),
                      trailing: Switch(
                        value: widget.user.darkMode,
                        onChanged: (value) {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .setDarkMode(value);
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Log out',
                      ),
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
      ),
    );
  }
}
