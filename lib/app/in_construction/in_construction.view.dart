import 'package:flutter/material.dart';

class InConstructionScreen extends StatelessWidget {
  const InConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Tính năng đang phát triển!'),
      ),
    );
  }
}
