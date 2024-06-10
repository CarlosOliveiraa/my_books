// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64CircleAvatar extends StatelessWidget {
  final String base64String;
  final double radius;

  Base64CircleAvatar({super.key, required this.base64String, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);

    return CircleAvatar(
      radius: radius,
      backgroundImage: MemoryImage(bytes),
      backgroundColor: Colors.transparent,
    );
  }
}
