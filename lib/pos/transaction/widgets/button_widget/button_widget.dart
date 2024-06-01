import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/payment/payment_widget.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/transaction_model.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.transactionOrderModel});

  final OrderModel transactionOrderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 48.0,
          width: 104.0,
          child: ElevatedButton(
            onPressed: () {
              if (transactionOrderModel.Items.isNotEmpty) {
                context.read<TransactionBloc>().add(
                      PostHoldOrder(
                        transactionOrderModel: TransactionOrderModel(
                          IdTransaction: transactionOrderModel.Id,
                          DineOption: transactionOrderModel.DineOption,
                          Items: transactionOrderModel.Items,
                        ),
                      ),
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No product added'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              "Hold",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: ElevatedButton(
              onPressed: () {
                if (transactionOrderModel.Items.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => const PaymentWidget(
                        // orderModel: transactionOrderModel,
                        ),
                  ).then(
                    (value) {
                      debugPrint(
                          'CALLBACK VALUE FROM PAYMENT PROCCESS | $value');
                      if (value == true) {
                        context.read<TransactionBloc>().add(
                              GetTransactions(),
                            );
                      }
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No product added'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
