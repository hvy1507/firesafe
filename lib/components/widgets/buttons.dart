import 'package:flutter/material.dart';

import '../resources/resources.dart';

@Deprecated('Use FilledButton with ThemeData instead.')
class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.onPressed, required this.child});

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: R.color.mainColor.withOpacity(0.5),
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ]),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return R.color.mainColor;
            } else {
              return R.color.mainColor;
            }
          }),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
        ),
        child: child,
      ),
    );
  }
}

@Deprecated('Use TonalButton with ThemeData instead.')
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.onPressed, required this.child});

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: R.color.secondaryColor.withOpacity(0.5),
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ]),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return R.color.secondaryColor;
            } else {
              return R.color.secondaryColor;
            }
          }),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
        ),
        child: child,
      ),
    );
  }
}

@Deprecated('Use OutlinedButton with ThemeData instead.')
class OptionalButton extends StatelessWidget {
  const OptionalButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.circular = false,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: circular ? null : BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(circular
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return Colors.black;
          }),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
        ),
        child: child,
      ),
    );
  }
}
