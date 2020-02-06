import 'package:flutter/material.dart';
import 'package:example/views/home.view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slider Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(title: 'Flutter Slider Example',),
    );
  }
}
