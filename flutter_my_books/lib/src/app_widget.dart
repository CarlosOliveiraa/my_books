import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/my_books_controller.dart';
import 'package:flutter_my_books/src/pages/home_page.dart';

import 'services/bloc/fetch_books/blocs/fetch_books_bloc.dart';
// import 'package:flutter_my_books/src/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MyBooksController();

    return BlocProvider(
      create: (context) => FetchBooksBloc(controller),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
