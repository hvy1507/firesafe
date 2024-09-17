import 'package:firesafe_vnex/themes/theme.dark.dart';
import 'package:firesafe_vnex/themes/theme.light.dart';
import 'package:flutter/material.dart';

class FireSafeTheme {
  FireSafeTheme._();

  static ThemeData theme({bool dark = false}) {
    return dark ? darkTheme : lightTheme;
  }
}