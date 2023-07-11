import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const _primaryColor = Color(0xff4169E1);

// final _darkScheme =
//     ColorScheme.fromSeed(seedColor: _primaryColor, brightness: Brightness.dark);

final _lightScheme = ColorScheme.fromSeed(
    seedColor: _primaryColor, brightness: Brightness.light);

final _palette = CorePalette.of(_primaryColor.value);

class SGColorTheme {
  static Color get primaryColor => _primaryColor;

  // static ColorScheme get darkScheme => _darkScheme;

  static ColorScheme get lightColorScheme => _lightScheme;

  static CorePalette get pallete => _palette;
}
