import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({
    bool leadingHashSign = true,
    bool includeAlpha = false,
  }) {
    final sb = StringBuffer();
    if (leadingHashSign) sb.write('#');
    if (includeAlpha) {
      sb.write(alpha.toRadixString(16).padLeft(2, '0'));
    }
    sb.write(red.toRadixString(16).padLeft(2, '0'));
    sb.write(green.toRadixString(16).padLeft(2, '0'));
    sb.write(blue.toRadixString(16).padLeft(2, '0'));
    return sb.toString();
  }
}
