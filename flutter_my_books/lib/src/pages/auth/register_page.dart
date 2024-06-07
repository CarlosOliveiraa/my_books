import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_books/src/controllers/auth/auth_controller.dart';
import 'package:flutter_my_books/src/pages/home_page.dart';
import 'package:flutter_my_books/src/params/user_params.dart';

import '../widgets/my_books_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
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
            hintText: 'Name',
            controller: nameController,
          ),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        child: MyBooksButton(
          width: 300,
          height: 50,
          title: 'Cadastrar',
          onTap: () {
            authController.signUp(
              params: UserParams(
                name: nameController.text,
                email: emailController.text,
                password: passController.text,
              ),
            );
          },
          backgroundColor: colors.primaryColor,
        ),
      ),
    );
  }
}
