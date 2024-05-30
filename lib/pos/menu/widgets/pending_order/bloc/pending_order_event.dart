part of 'pending_order_bloc.dart';

class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOrders extends OrderEvent {
  GetOrders ({
    required this.status,
  });

  final String status;

  @override
  List<Object?> get props => [status];
}