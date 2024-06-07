import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/auth/auth_controller.dart';
import 'package:flutter_my_books/src/pages/home_page.dart';
import 'package:flutter_my_books/src/services/bloc/auth/bloc/auth_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/auth/event/auth_events.dart';
import 'package:flutter_my_books/src/services/bloc/auth/state/auth_states.dart';

import '../widgets/my_books_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>()!;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyBooksTextField(
            hintText: 'Email',
            controller: emailController,
          ),
          MyBooksTextField(
            hintText: 'Password',
            controller: passController,
          ),
        ],
      ),
      bottomNavigationBar:
          BlocConsumer<AuthBloc, AuthStates>(listener: (context, state) {
        if (state is FetchUserSuccessState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(user: state.user)));
        }
      }, builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          child: MyBooksButton(
            width: 300,
            height: 50,
            title: 'Cadastrar',
            onTap: () {
              context.read<AuthBloc>().add(
                    FetchUserEvent(
                      email: emailController.text,
                      password: passController.text,
                    ),
                  );
            },
            backgroundColor: colors.primaryColor,
          ),
        );
      }),
    );
  }
}
