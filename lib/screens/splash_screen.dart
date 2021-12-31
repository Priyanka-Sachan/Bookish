import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
            SvgPicture.asset(
              'assets/images/splash_screen_logo.svg',
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
