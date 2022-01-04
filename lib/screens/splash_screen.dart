import 'package:bookish/models/bookish_pages.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: BookishPages.splashPath,
      key: ValueKey(BookishPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_screen_logo.png',
              width: MediaQuery.of(context).size.width - 32,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'BOOKISH',
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
