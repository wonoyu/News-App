import 'package:flutter/material.dart';
import 'package:news_app/src/core/constants/colors.dart';

final appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
    primary: cardinalRed,
    onPrimary: mistyRose,
    secondary: persimmon,
    onSecondary: antiqueWhite,
    tertiary: darkMagenta,
    onTertiary: snowWhite,
    background: whiteSmoke,
    onBackground: black,
    error: crimson,
    onError: mistyRose,
    surface: cardinalRed,
    onSurface: mistyRose,
  ));
}
