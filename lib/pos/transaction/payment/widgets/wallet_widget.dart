import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/payment_method_list_model.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key,
    required this.transactionOrderModel,
    required this.paymentMethodListModel,
    required this.paymentMethodName,
  });
  final OrderModel transactionOrderModel;
  final PaymentMethodListModel paymentMethodListModel;
  final String paymentMethodName;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController totalPaymentController = TextEditingController();
  TextEditingController changeController = TextEditingController();

  double totalPayment = 0;

  @override
  void dispose() {
    totalPaymentController.dispose();
    totalPriceController.dispose();
    changeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    totalPriceController.text = NumberFormat.simpleCurrency(locale: "id-ID")
        .format(widget.transactionOrderModel.TotalPrice);
    changeController.text =
        NumberFormat.simpleCurrency(locale: "id-ID").format(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Price *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Input note...',
            ),
            controller: totalPriceController,
            enabled: false,
            readOnly: true,
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Payment *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        const SizedBox(height: 24.0),
        const Text(
          'Upload Image *',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            SizedBox(
              height: 48.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
            const Text(''),
          ],
        ),
      ],
    );
  }
}