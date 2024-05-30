import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/pending_order/bloc/pending_order_bloc.dart';
import 'package:pos_kawani/repository/pos_repository.dart';

class PendingOrderWidget extends StatelessWidget {
  // const PendingOrderWidget({super.key, required this.orders});
  const PendingOrderWidget({super.key});

  // final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBloc(posRepository: context.read<PosRepository>()),
      child: Container(
        margin: const EdgeInsets.all(96.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HoldOrder'),
                const SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Text(state.orders[index].Id!),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 24.0,
                    ),
                    itemCount: state.orders.length,
                  ),
                ),
                // const Expanded(
                //     child: Center(
                //   child: CircularProgressIndicator(),
                // )),
              ],
            );
          },
        ),
      ),
    );
  }
}
