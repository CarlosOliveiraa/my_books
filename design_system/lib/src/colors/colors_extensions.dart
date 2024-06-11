import 'package:flutter/material.dart';

class ColorsExtensions extends ThemeExtension<ColorsExtensions> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? baseColorShimmer;
  final Color? highlightColorShimmer;

  ColorsExtensions({
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
    this.baseColorShimmer,
    this.highlightColorShimmer,
  });

  @override
  ThemeExtension<ColorsExtensions> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? baseColorShimmer,
    Color? highlightColorShimmer,
  }) {
    return ColorsExtensions(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
      baseColorShimmer: baseColorShimmer ?? this.baseColorShimmer,
      highlightColorShimmer:
          highlightColorShimmer ?? this.highlightColorShimmer,
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
        baseColorShimmer:
            Color.lerp(baseColorShimmer, other.baseColorShimmer, t),
        highlightColorShimmer:
            Color.lerp(highlightColorShimmer, other.highlightColorShimmer, t));
  }
}
