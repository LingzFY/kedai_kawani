import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Subtotal"),
              const Spacer(),
              Text(
                NumberFormat.simpleCurrency(locale: "id-ID")
                    .format(totalPrice),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text("Total Price"),
              const Spacer(),
              Text(
                NumberFormat.simpleCurrency(locale: "id-ID")
                    .format(totalPrice),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
