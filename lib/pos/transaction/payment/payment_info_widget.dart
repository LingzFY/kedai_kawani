import 'package:flutter/material.dart';
import 'package:pos_kawani/pos/transaction/widgets/list_widget/list_widget.dart';
import 'package:pos_kawani/pos/transaction/widgets/price_widget/price_widget.dart';
import 'package:pos_kawani/repository/models/order_model.dart';

class PaymentInfoWidget extends StatelessWidget {
  const PaymentInfoWidget({
    super.key,
    required this.ctx,
    required this.orderModel,
    required this.trxNo,
  });

  final BuildContext ctx;
  final String trxNo;
  final OrderModel orderModel;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(ctx, false);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Confirmation For Transaction',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
          Text(
            '#${orderModel.TrxNo}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 24.0),
          const Divider(),
          const SizedBox(height: 24.0),
          ListWidget(transactionItemList: orderModel.Items),
          const SizedBox(height: 24.0),
          PriceWidget(totalPrice: orderModel.TotalPrice!),
        ],
      ),
    );
  }
}
