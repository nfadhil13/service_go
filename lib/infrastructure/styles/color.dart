import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:sizer/sizer.dart';

const _primaryColor = Color(0xff4169E1);

// final _darkScheme =
//     ColorScheme.fromSeed(seedColor: _primaryColor, brightness: Brightness.dark);

final _lightScheme = ColorScheme.fromSeed(
    seedColor: _primaryColor, brightness: Brightness.light);

final _palette = CorePalette.of(_primaryColor.value);

class ServiceGoTheme {
  static Color get primaryColor => _primaryColor;

  // static ColorScheme get darkScheme => _darkScheme;

  static ColorScheme get lightColorScheme => _lightScheme;

  static CorePalette get pallete => _palette;

  static String get fontFamily => "Poppins";

  static TextStyle buildTextStyle(double fontSize, double height) => TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      height: height.sp.toFigmaHeight(fontSize.sp));

  static TextTheme get textTheme => TextTheme(
      displayLarge: buildTextStyle(57, 64),
      displayMedium: buildTextStyle(45, 52),
      displaySmall: buildTextStyle(36, 44),
      headlineLarge: buildTextStyle(32, 40),
      headlineMedium: buildTextStyle(28, 36),
      headlineSmall: buildTextStyle(24, 32),
      titleLarge: buildTextStyle(22, 28),
      titleMedium: buildTextStyle(16, 24),
      titleSmall: buildTextStyle(14, 20),
      bodyLarge: buildTextStyle(16, 24),
      bodyMedium: buildTextStyle(14, 20),
      bodySmall: buildTextStyle(12, 16),
      labelLarge: buildTextStyle(14, 20),
      labelMedium: buildTextStyle(12, 16),
      labelSmall: buildTextStyle(11, 16));
}

extension FigmaDimention on num {
  double toFigmaHeight(num fontSize) {
    return this / fontSize;
  }
}
