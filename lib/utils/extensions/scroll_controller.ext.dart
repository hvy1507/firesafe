import 'package:flutter/material.dart';

extension ScrollControllerExtension on ScrollController {
  void onScrollToEnd(Function() callback) {
    void listener() {
      if (position.pixels == position.maxScrollExtent) {
        callback();
      }
    }

    addListener(listener);
  }
}
