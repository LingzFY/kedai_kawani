import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/pos/transaction/widgets/button_widget/button_widget.dart';
import 'package:pos_kawani/pos/transaction/widgets/dine_option_widget/dine_option_widget.dart';
import 'package:pos_kawani/pos/transaction/widgets/header_widget/header_widget.dart';
import 'package:pos_kawani/pos/transaction/widgets/list_widget/list_widget.dart';
import 'package:pos_kawani/pos/transaction/widgets/price_widget/price_widget.dart';
import 'package:pos_kawani/widgets/error_widget.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.35,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state.status.isAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product have been added'),
              ),
            );
          } else if (state.status.isRemoved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product have been removed'),
              ),
            );
          } else if (state.status.isCleared) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product list have been cleaned'),
              ),
            );
          } else if (state.status.isHeld) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product list have been held'),
              ),
            );
          } else if (state.status.isPayed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product list have been paid'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isError) {
            return const ErrorPosWidget();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(trxNo: state.transactionOrderModel.TrxNo!),
              const SizedBox(height: 24.0),
              DineOptionWidget(
                  dineOption: state.transactionOrderModel.DineOption!),
              const SizedBox(height: 32.0),
              const Row(
                children: [
                  Expanded(
                    child: Text('Product List'),
                  ),
                  SizedBox(
                    width: 96,
                    child: Text('Quantity'),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ListWidget(
                  transactionItemList: state.transactionOrderModel.Items),
              const SizedBox(height: 24.0),
              PriceWidget(totalPrice: state.transactionOrderModel.TotalPrice!),
              const SizedBox(height: 24.0),
              ButtonWidget(transactionOrderModel: state.transactionOrderModel),
            ],
          );
        },
      ),
    );
  }
}
