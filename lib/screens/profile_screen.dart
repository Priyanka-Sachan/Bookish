import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/models/user.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
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
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profileImageUrl),
              radius: 60,
            ),
            Text(widget.user.username),
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
                            .darkMode = value;
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
