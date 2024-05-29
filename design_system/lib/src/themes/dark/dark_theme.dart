import 'package:flutter/material.dart';

import '../../colors/colors.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    primary: const Color(0xff49f170),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  extensions: [colors],
);
