import 'package:bookish/models/user.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  User user = User(
      username: 'Anonymous',
      profileImageUrl:
          "https://media.istockphoto.com/photos/good-book-can-do-the-world-of-good-picture-id1257761640?b=1&k=20&m=1257761640&s=170667a&w=0&h=TkLOhtnBo88Iw6lOZ3fPFT6ZJ-TQ388d4GVdkvRd4HE=",
      darkMode: false);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    widget.user = Provider.of<ProfileProvider>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // TODO: Close Profile Screen
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
                      // TODO: Logout user
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
