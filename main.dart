import 'package:flutter/material.dart';
import 'package:ammap/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterScreen(), // Set RegisterScreen as the initial screen
    );
  }
}
