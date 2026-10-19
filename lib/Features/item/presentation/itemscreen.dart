import 'package:flutter/material.dart';
import 'package:shamedan/core/widgets/customAppBar.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Item Screen'),
      ),
    );
  }
}