import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_books/src/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    );
  }
}
