import 'package:flutter/material.dart';

class ColorUtil {
  static Color hexToColor(String hexString) {
    // Menghilangkan karakter '#' jika ada
    if (hexString.startsWith('#')) {
      hexString = hexString.substring(1);
    }

    // Periksa panjang string, harus 6 atau 8 karakter (dengan alpha)
    if (hexString.length == 6) {
      hexString = 'FF$hexString'; // Tambahkan alpha 'FF' (100% opasitas)
    } else if (hexString.length != 8) {
      throw ArgumentError('Hex string has to be 6 or 8 characters');
    }

    // Parse string hex menjadi integer
    int colorValue = int.parse(hexString, radix: 16);

    // Kembalikan objek Color dari nilai integer
    return Color(colorValue);
  }
}
