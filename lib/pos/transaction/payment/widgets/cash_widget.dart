import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/payment_method_list_model.dart';

class CashWidget extends StatefulWidget {
  const CashWidget({
    super.key,
    required this.transactionOrderModel,
    required this.paymentMethodListModel,
    required this.paymentMethodName,
  });
  final OrderModel transactionOrderModel;
  final PaymentMethodListModel paymentMethodListModel;
  final String paymentMethodName;

  @override
  State<CashWidget> createState() => _CashWidgetState();
}

class _CashWidgetState extends State<CashWidget> {
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
    context.read<TransactionBloc>().add(
          SetPaymentMethod(
            paymentMethodId: 1,
            paymentRefference: '',
          ),
        );

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
              hintText: '0',
            ),
            controller: totalPaymentController,
            autofocus: true,
            onChanged: (value) {
              context.read<TransactionBloc>().add(
                    SetTotalPayment(
                      totalPayment: totalPayment = (value.isEmpty) ? 0 : double.parse(value),
                    ),
                  );

              setState(() {
                totalPayment = (value.isEmpty) ? 0 : double.parse(value);
                double change = 0;
                if (double.parse(value) >
                    widget.transactionOrderModel.TotalPrice!) {
                  change =
                      totalPayment - widget.transactionOrderModel.TotalPrice!;
                  changeController.text =
                      NumberFormat.simpleCurrency(locale: "id-ID")
                          .format(change);
                  debugPrint(change.toString());
                } else {
                  changeController.text =
                      NumberFormat.simpleCurrency(locale: "id-ID").format(0);
                }
              });
            },
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Change *',
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
            controller: changeController,
            enabled: false,
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
