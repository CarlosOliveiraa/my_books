import 'package:flutter/material.dart';

class MyBooksTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const MyBooksTextField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      this.maxLines,
      this.controller,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
