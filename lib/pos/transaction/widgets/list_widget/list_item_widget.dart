import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';

typedef TransactionItemClicked = Function(
    TransactionItemModel transactionItemModel);

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.transactionItem,
    required this.callbackAddQty,
    required this.callbackReduceQty,
    required this.callbackRemoveItem,
  });

  final TransactionItemModel transactionItem;
  final TransactionItemClicked callbackAddQty;
  final TransactionItemClicked callbackReduceQty;
  final TransactionItemClicked callbackRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              loadImage(transactionItem.Product?.ImageUrl),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionItem.Product!.Name!,
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: "id-ID")
                          .format(transactionItem.Product?.Price!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 48,
                width: 48,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackReduceQty(transactionItem),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Container(
                width: 48,
                alignment: Alignment.center,
                child: Text(
                  transactionItem.Qty!.toString(),
                ),
              ),
              SizedBox(
                height: 48,
                width: 48,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackAddQty(transactionItem),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Order Note',
                    ),
                    onChanged: (value) {
                      context.read<TransactionBloc>().add(
                            AddTransactionItemNote(
                              newNote: value.toString(),
                              transactionItemModel: transactionItem,
                            ),
                          );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 48,
                width: 48,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackRemoveItem(transactionItem),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  loadImage(String? imageUrl) {
    return (imageUrl == null || imageUrl == "")
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.asset(
              "assets/images/example_image.jpg",
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.network(
              imageUrl,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          );
  }
}
