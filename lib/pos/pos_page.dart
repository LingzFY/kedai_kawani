import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/menu_page.dart';
import 'package:pos_kawani/pos/menu/widgets/category_widget/bloc/category_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/bloc/product_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/pending_order/bloc/pending_order_bloc.dart';
import 'package:pos_kawani/pos/transaction/bloc/transaction_bloc.dart';
import 'package:pos_kawani/pos/transaction/transaction_page.dart';
import 'package:pos_kawani/repository/pos_repository.dart';
import 'package:pos_kawani/repository/services/pos_service.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: RepositoryProvider(
          create: (context) => PosRepository(service: PosService()),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc(
                  posRepository: context.read<PosRepository>(),
                )..add(GetCategories()),
              ),
              BlocProvider<ProductBloc>(
                create: (context) => ProductBloc(
                  posRepository: context.read<PosRepository>(),
                )..add(
                    GetProducts(
                      idCategory: '',
                    ),
                  ),
              ),
              BlocProvider<TransactionBloc>(
                create: (context) => TransactionBloc(
                  posRepository: context.read<PosRepository>(),
                )..add(GetTransactions()),
              ),
              BlocProvider<OrderBloc>(
                create: (context) => OrderBloc(
                  posRepository: context.read<PosRepository>(),
                )..add(GetOrders(status: 'HOLD')),
              ),
            ],
            child: const Column(
              children: [
                Row(
                  children: [
                    MenuPage(),
                    TransactionPage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
