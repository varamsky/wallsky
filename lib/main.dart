import 'package:flutter/material.dart';
import 'package:wallsky/screens/homeScreen.dart';
import 'package:wallsky/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
      ),
      home: HomeScreen(),
    );
  }
}
