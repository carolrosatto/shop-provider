import 'package:flutter/material.dart';

class ColorPalette extends Color {
  const ColorPalette(int value) : super(value);
}

class CustomPalette {
  CustomPalette._();

  static const backgroundLight = ColorPalette(0xffffffff);
  static const brandTertiaryLight = ColorPalette(0xfff5f5);
  static const shadowLight = ColorPalette(0xc4c4c4);
  static const brandSecondaryLight = ColorPalette(0xf26037);
  static const brandPrimaryLight = ColorPalette(0xd4183f);
  static const secondButtonLight = ColorPalette(0x8e0e2f);
  static const textSecondaryColor = ColorPalette(0x672b1a);
  static const textPrimaryColor = ColorPalette(0x00000000);
}
