import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  /// Custom widget that add Material ripple effect on top of a decorated widget.
  const Clickable({
    super.key,
    this.child,
    required this.onTap,
    // this.stackChildren,
  });

  final Widget? child;

  // final List<Widget>? stackChildren;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (child != null)
          child!,
        // if (stackChildren != null) ...stackChildren!,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
