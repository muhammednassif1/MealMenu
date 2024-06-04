import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/main_catagory_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainCategoryScreen(),
    );
  }
}
