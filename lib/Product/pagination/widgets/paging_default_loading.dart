import 'package:flutter/material.dart';

class PagingDefaultLoading extends StatelessWidget {
  const PagingDefaultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}