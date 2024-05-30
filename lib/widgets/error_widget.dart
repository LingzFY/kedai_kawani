import 'package:flutter/material.dart';

class ErrorPosWidget extends StatelessWidget {
  const ErrorPosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something was wrong',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}