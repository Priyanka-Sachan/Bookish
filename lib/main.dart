import 'package:bookish/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = BookishTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Bookish',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bookish', style: theme.textTheme.headline6),
        ),
        body: Center(
          child: Text('Bookish', style: theme.textTheme.headline1),
        ),
      ),
    );
  }
}
