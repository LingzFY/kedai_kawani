import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.trxNo});

  final String trxNo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Order List ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
              ),
            ),
            Text(
              '#$trxNo',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
              ),
            ),
          ],
        ),
        const Text(
          'Dine Options',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
