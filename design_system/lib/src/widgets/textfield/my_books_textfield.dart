import 'package:flutter/material.dart';

class MyBooksTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;

  const MyBooksTextField(
      {super.key, required this.hintText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
