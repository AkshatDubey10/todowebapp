import 'package:flutter/material.dart';
import 'package:todowebapp/screens/home.dart';
import 'package:todowebapp/screens/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OverpassRegular',
        primaryColor: Color(0xFF3185FC),
        scaffoldBackgroundColor: Color(0xFFFFFAFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }
}
