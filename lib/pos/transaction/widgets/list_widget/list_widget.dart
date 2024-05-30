import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/pos/transaction/widgets/list_widget/list_item_widget.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.transactionItemList});

  final List<TransactionItemModel> transactionItemList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: transactionItemList.length,
        itemBuilder: (BuildContext context, int i) {
          return ListItemWidget(
            transactionItem: transactionItemList[i],
            callbackAddQty: (TransactionItemModel transactionItem) {
              context.read<TransactionBloc>().add(
                    AddTransactionItemQty(
                      targetIndex: i,
                      transactionItemModel: transactionItemList[i],
                    ),
                  );
            },
            callbackReduceQty: (TransactionItemModel transactionItem) {
              context.read<TransactionBloc>().add(
                    ReduceTransactionItemQty(
                      targetIndex: i,
                      transactionItemModel: transactionItemList[i],
                    ),
                  );
            },
            callbackRemoveItem: (TransactionItemModel transactionItem) {
              context.read<TransactionBloc>().add(
                    RemoveTransactionItemList(
                      transactionItemModel: transactionItemList[i],
                    ),
                  );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 24);
        },
      ),
    );
  }
}
