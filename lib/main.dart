import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookish',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bookish'),
        ),
        body: Center(
          child: Text('Bookish'),
        ),
      ),
    );
  }
}
