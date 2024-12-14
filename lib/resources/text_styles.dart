import 'package:flutter/material.dart';

// These classes are not meant to be instantiated or extended; this constructor
// prevents instantiation  and extension

class AppFontFamily {
  const AppFontFamily._();
  static String get facebookSans => 'FacebookSans';
}

class AppFontSizes {
  const AppFontSizes._();
  static double scale = 1;

  static double get heading1 => 32 * scale;
  static double get heading2 => 24 * scale;
  static double get heading3 => 20 * scale;
  static double get body => 16 * scale;
  static double get caption => 14 * scale;
  static double get footnote => 12 * scale;
}

class AppTextStyles {
  const AppTextStyles._();
  static TextStyle get appFont =>
      TextStyle(fontFamily: AppFontFamily.facebookSans);

  /// with font size 32
  static TextStyle get heading1 =>
      appFont.copyWith(fontSize: AppFontSizes.heading1);

  /// with font size 24
  static TextStyle get heading2 =>
      appFont.copyWith(fontSize: AppFontSizes.heading2);

  /// with font size 20
  static TextStyle get heading3 =>
      appFont.copyWith(fontSize: AppFontSizes.heading3);

  /// with font size 16
  static TextStyle get body => appFont.copyWith(fontSize: AppFontSizes.body);

  /// with font size 14
  static TextStyle get caption =>
      appFont.copyWith(fontSize: AppFontSizes.caption);

  /// with font size 12
  static TextStyle get footnote =>
      appFont.copyWith(fontSize: AppFontSizes.footnote);
}

extension TextStyleHelpers on TextStyle {
  /// with font weight 900
  TextStyle get heavy => copyWith(fontWeight: FontWeight.w900);

  /// with font weight 700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// with font weight 400
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// with font weight 300
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle size(double value) => copyWith(fontSize: value);
  TextStyle textColor(Color? value) => copyWith(color: value);
}
