import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/bloc/product_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/product_item.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/repository/models/product_model.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';

class ProductSuccessWidget extends StatelessWidget {
  const ProductSuccessWidget({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return FlexibleGridView(
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          axisCount: GridLayoutEnum.fourElementsInRow,
          physics: const BouncingScrollPhysics(),
          children: [
            for (int i = 0; i < state.products.Items.length; i++)
              ProductItem(
                product: state.products.Items[i],
                callback: (ProductModel productModel) {
                  context.read<TransactionBloc>().add(
                        AddTransactionItemList(
                          transactionItemModel: TransactionItemModel(
                            Id: productModel.Id,
                            idItem: productModel.Id,
                            Qty: 1,
                            Product: productModel,
                            Notes: '',
                            Description: '',
                          ),
                        ),
                      );
                },
              ),
          ],
        );
      },
    );
  }
}
