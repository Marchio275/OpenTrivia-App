import 'package:flutter/material.dart';
import 'package:opentrivia/ui/pagine/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Trivia',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          fontFamily: "Montserrat",
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textTheme: ButtonTextTheme.primary)),
      home: Homepage(),
    );
  }
}
