import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'image.dart';

class FSBackButton extends StatelessWidget {
  const FSBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FSImage.asset(
        imageResource: R.image.vector.arrowBack,
        width: 32,
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
