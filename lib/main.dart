import 'package:flutter/material.dart';
import 'package:lyrikator/routes/SearchRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrikator',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: SearchRoute(),
    );
  }
}