import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/resources/resources.dart';

const _buttonTextStyle = TextStyle(
  fontFamily: 'GoogleSans',
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const _appBarTitleStyle = TextStyle(
  fontFamily: 'GoogleSans',
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 20,
);

class MyExtension extends ThemeExtension<MyExtension> {
  @override
  ThemeExtension<MyExtension> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<MyExtension> lerp(covariant ThemeExtension<MyExtension>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: R.color.mainColor,
    primary: R.color.mainColor,
    onPrimary: Colors.white,
    primaryContainer: R.color.mainColor.withOpacity(0.2),
    onPrimaryContainer: R.color.mainColor,
    shadow: R.color.mainColor.withOpacity(0.25),
    secondary: R.color.secondaryColor,
    onSecondary: Colors.white,
    secondaryContainer: R.color.mainColor.withOpacity(0.2),
    onSecondaryContainer: R.color.mainColor,
  ),
  fontFamily: 'GoogleSans',
  typography: Typography.material2021(),
  textTheme: const TextTheme(
    displayLarge: TextStyle(),
    displayMedium: TextStyle(),
    displaySmall: TextStyle(),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(),
    titleLarge: TextStyle(),
    titleMedium: TextStyle(),
    titleSmall: TextStyle(),
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
    bodySmall: TextStyle(),
    labelLarge: TextStyle(),
    labelMedium: TextStyle(),
    labelSmall: TextStyle(),
  ).apply(
    displayColor: R.color.secondaryColor,
    bodyColor: R.color.secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: R.color.mainColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 16,
    ),
    filled: true,
    fillColor: R.color.textFieldColor,
    iconColor: R.color.mainColor,
    prefixIconColor: R.color.mainColor,
    suffixIconColor: R.color.mainColor,
  ),
  iconTheme: IconThemeData(
    size: 24,
    color: R.color.mainColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    // toolbarHeight: 72,
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: false,
    surfaceTintColor: Colors.white,
    titleTextStyle: _appBarTitleStyle,
    iconTheme: const IconThemeData(
      size: 28,
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      size: 28,
      color: R.color.mainColor,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: IconThemeData(color: R.color.mainColor),
    unselectedIconTheme: IconThemeData(color: R.color.secondaryColor),
    enableFeedback: false,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shadowColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.transparent;
        } else {
          return R.color.mainColor.withOpacity(0.25);
        }
      }),
      elevation: MaterialStateProperty.all(24),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      textStyle: MaterialStateProperty.all(
        _buttonTextStyle.copyWith(color: Colors.white),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      shape: MaterialStateProperty.all(const StadiumBorder()),
      side: MaterialStateProperty.all(BorderSide(
        color: R.color.mainColor,
        width: 2,
      )),
      textStyle: MaterialStateProperty.all(
        _buttonTextStyle.copyWith(color: R.color.mainColor),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      foregroundColor: MaterialStateProperty.all(R.color.secondaryColor),
      overlayColor: MaterialStateProperty.all(R.color.secondaryColor.withOpacity(0.2)),
      textStyle: MaterialStateProperty.all(_buttonTextStyle),
    ),
  ),
  cardColor: Colors.white,
  cardTheme: CardTheme(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(
        width: 2,
        color: Colors.grey.shade200,
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade200,
    space: 0,
    thickness: 2,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    shadowColor: R.color.mainColor,
    showCheckmark: false,
    pressElevation: 4,
    selectedColor: R.color.mainColor,
    shape: StadiumBorder(
      side: BorderSide(color: Colors.grey.shade500),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      )),
      elevation: MaterialStateProperty.all(4),
      maximumSize: MaterialStateProperty.all(const Size.fromHeight(500)),
      shadowColor: MaterialStateProperty.all(Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      iconColor: R.color.mainColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: R.color.mainColor,
        ),
      ),
    ),
  ),
);
