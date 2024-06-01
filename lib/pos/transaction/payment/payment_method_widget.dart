import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/payment/widgets/cash_widget.dart';
import 'package:pos_kawani/pos/transaction/payment/widgets/transfer_widget.dart';
import 'package:pos_kawani/pos/transaction/payment/widgets/wallet_widget.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/transaction_model.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String paymentMethodName = 'CASH';
  // TransactionOrderModel transactionOrderModel = TransactionOrderModel.empty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.35,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64.0),
              const Text(
                'Payment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
              const Text(
                '3 payment method available',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const Divider(),
              const SizedBox(height: 24.0),
              const Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentMethodName = 'CASH';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: (paymentMethodName == 'CASH')
                              ? Colors.orange.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: (paymentMethodName == 'CASH')
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.payments_rounded,
                              color: (paymentMethodName == 'CASH')
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Cash',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: (paymentMethodName == 'CASH')
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentMethodName = 'TRANSFER';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: (paymentMethodName == 'TRANSFER')
                              ? Colors.orange.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: (paymentMethodName == 'TRANSFER')
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.payment_rounded,
                              color: (paymentMethodName == 'TRANSFER')
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Transfer',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: (paymentMethodName == 'TRANSFER')
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentMethodName = 'WALLET';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: (paymentMethodName == 'WALLET')
                              ? Colors.orange.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: (paymentMethodName == 'WALLET')
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.wallet_rounded,
                              color: (paymentMethodName == 'WALLET')
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'E-wallet',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: (paymentMethodName == 'WALLET')
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              (paymentMethodName == 'CASH')
                  ? Expanded(
                      child: CashWidget(
                        transactionOrderModel: state.transactionOrderModel,
                        paymentMethodListModel: state.paymentMethods,
                        paymentMethodName: paymentMethodName,
                      ),
                    )
                  : (paymentMethodName == 'TRANSFER')
                      ? Expanded(
                          child: TransferWidget(
                            transactionOrderModel: state.transactionOrderModel,
                            paymentMethodListModel: state.paymentMethods,
                            paymentMethodName: paymentMethodName,
                          ),
                        )
                      : (paymentMethodName == 'WALLET')
                          ? Expanded(
                              child: WalletWidget(
                                transactionOrderModel:
                                    state.transactionOrderModel,
                                paymentMethodListModel: state.paymentMethods,
                                paymentMethodName: paymentMethodName,
                              ),
                            )
                          : const Expanded(
                              child: SizedBox(),
                            ),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 48.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    TransactionOrderModel transactionOrderModel =
                        TransactionOrderModel(
                      IdTransaction: state.transactionOrderModel.Id,
                      DineOption: state.transactionOrderModel.DineOption,
                      Items: state.transactionOrderModel.Items,
                      TotalPayment: state.totalPayment,
                      PaymentMethodId: state.paymentMethodId,
                      PaymentRefference: state.paymentRefference,
                      PaymentFile: state.transactionFileModel,
                    );

                    debugPrint(transactionOrderModel.toJson());

                    context.read<TransactionBloc>().add(
                          PaymentOrder(
                            transactionOrderModel: transactionOrderModel,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
