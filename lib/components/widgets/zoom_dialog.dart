import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:flutter/material.dart';

void showZoomDialog({required BuildContext context, required Widget child}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          child: child,
        ),
      );
    },
  );
}