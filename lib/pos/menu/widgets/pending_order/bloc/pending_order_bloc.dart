import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/pos_repository.dart';

part 'pending_order_state.dart';
part 'pending_order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required this.posRepository,
  }) : super(const OrderState()) {
    on<GetOrders>(_mapGetOrderEventToState);
  }

  final PosRepository posRepository;

  void _mapGetOrderEventToState(
      GetOrders event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final orders = await posRepository.getHoldOrders(event.status);
      emit(
        state.copyWith(
          status: OrderStatus.success,
          orders: orders.Items,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: OrderStatus.error));
    }
  }
}