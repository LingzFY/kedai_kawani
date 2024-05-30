import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/bloc/product_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/product_success_widget.dart';
import 'package:pos_kawani/widgets/error_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isError) {
            return const ErrorPosWidget();
          }
          return ProductSuccessWidget(
            products: state.products.Items,
          );
        },
      ),
    );
  }
}
