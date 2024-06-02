import 'package:flutter/material.dart';

class ColorsExtensions extends ThemeExtension<ColorsExtensions> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;

  ColorsExtensions({
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
  });

  @override
  ThemeExtension<ColorsExtensions> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
  }) {
    return ColorsExtensions(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
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
      errorColor: Color.lerp(errorColor, other.errorColor, t),
    );
  }
}
