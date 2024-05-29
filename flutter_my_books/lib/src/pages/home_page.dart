import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_books/src/pages/widgets/empty_list.dart';
import 'package:flutter_my_books/src/pages/widgets/my_books_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>();
    debugPrint('Cor primária => ${colors!.primaryColor}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EmptyList(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 300,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(30),
        child: MyBooksButton(
          width: 300,
          height: 50,
          title: 'Adicionar',
          backgroundColor: colors.primaryColor,
        ),
      ),
    );
  }
}
