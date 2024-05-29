import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    debugPrint('Brightness => $brightness');

    return Column(
      children: [
        SizedBox(
          width: 150,
          child: Image.asset('assets/images/png/book.png'),
        ),
        const SizedBox(height: 10),
        Text(
          'Você não possui livros ainda',
          style: TextStyle(
              color:
                  brightness == Brightness.dark ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
