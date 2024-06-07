import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/l10n/l10n.dart';
import 'package:flutter_my_books/src/controllers/auth/auth_controller.dart';
import 'package:flutter_my_books/src/controllers/books/my_books_controller.dart';
import 'package:flutter_my_books/src/pages/auth/login_page.dart';
import 'package:flutter_my_books/src/services/bloc/auth/bloc/auth_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/books/blocs/send_book_bloc.dart';

import 'services/bloc/books/blocs/fetch_books_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MyBooksController();
    final authController = AuthController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authController)),
        BlocProvider(create: (context) => FetchBooksBloc(controller)),
        BlocProvider(create: (context) => SendBookBloc(controller)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const LoginPage(),
      ),
    );
  }
}
