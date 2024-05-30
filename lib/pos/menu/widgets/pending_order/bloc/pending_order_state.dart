part of 'pending_order_bloc.dart';

// ignore_for_file: prefer_initializing_formals

enum OrderStatus { initial, success, error, loading }

extension OrderStatusX on OrderStatus {
  bool get isInitial => this == OrderStatus.initial;
  bool get isSuccess => this == OrderStatus.success;
  bool get isError => this == OrderStatus.error;
  bool get isLoading => this == OrderStatus.loading;
}

class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.initial,
    List<OrderModel>? orders,
  })  : orders = orders ?? const [];

  final List<OrderModel> orders;
  final OrderStatus status;

  @override
  List<Object?> get props => [status, orders];

  OrderState copyWith({
    List<OrderModel>? orders,
    OrderStatus? status
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}
