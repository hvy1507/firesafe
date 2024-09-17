import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources/resources.dart';

class FSProgressIndicator extends StatelessWidget {
  const FSProgressIndicator({
    super.key,
    this.color = Colors.white,
    this.size = 24,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        size: size,
        color: R.color.mainColor,
      ),
    );
  }
}
