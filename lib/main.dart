import 'package:flutter/material.dart';
import 'package:restofoods/ui/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restofood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent
      ),
      home: HomeScreen(),
      routes: {
        "/home" : (context) => HomeScreen()
      },
    );
  }
}