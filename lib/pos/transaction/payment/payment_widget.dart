import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/payment/payment_info_widget.dart';
import 'package:pos_kawani/pos/transaction/payment/payment_method_widget.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/pos_repository.dart';
import 'package:pos_kawani/repository/services/pos_service.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RepositoryProvider(
        create: (context) => PosRepository(service: PosService()),
        child: BlocProvider(
          create: (context) => TransactionBloc(
            posRepository: context.read<PosRepository>(),
          )..add(GetPaymentMethods()),
          child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state.status.isPaid) {
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PaymentInfoWidget(
                    ctx: context,
                    trxNo: state.transactionOrderModel.TrxNo!,
                    orderModel: state.transactionOrderModel,
                  ),
                  PaymentMethodWidget(
                    orderModel: state.transactionOrderModel,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
