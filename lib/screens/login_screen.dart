import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: BookishPages.loginPath,
      key: ValueKey(BookishPages.loginPath),
      child: LoginScreen(),
    );
  }

  final String? username;

  LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: SvgPicture.asset(
                'assets/images/splash_screen_logo.svg',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              maxLength: 32,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  Provider.of<AppStateProvider>(context, listen: false)
                      .login('mockUsername', 'mockPassword');
                },
                child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
