import 'package:flutter/material.dart';

class ColorsExtensions extends ThemeExtension<ColorsExtensions> {
  final Color? primaryColor;
  final Color? secondaryColor;

  ColorsExtensions({
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  ThemeExtension<ColorsExtensions> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return ColorsExtensions(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<ColorsExtensions> lerp(
      covariant ThemeExtension<ColorsExtensions>? other, double t) {
    if (other is! ColorsExtensions) {
      return this;
    }

    return ColorsExtensions(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
    );
  }
}
