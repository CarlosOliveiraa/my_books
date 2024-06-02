import 'package:design_system/src/colors/colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff49f170),
    brightness: Brightness.light,
    primary: const Color(0xff49f170),
  ),
  useMaterial3: true,
  extensions: [colors],
);
