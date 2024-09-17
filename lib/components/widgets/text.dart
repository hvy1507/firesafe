import 'package:flutter/material.dart';

extension TextExtensionState on BuildContext {
  TextStyle get displayL => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayM => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displayS => Theme.of(this).textTheme.displaySmall!;
  TextStyle get headlineL => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineM => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineS => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get titleL => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleM => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleS => Theme.of(this).textTheme.titleSmall!;
  TextStyle get bodyL => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyM => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodyS => Theme.of(this).textTheme.bodySmall!;
  TextStyle get labelL => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelM => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelS => Theme.of(this).textTheme.labelMedium!;
}