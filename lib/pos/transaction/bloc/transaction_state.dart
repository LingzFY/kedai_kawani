part of 'transaction_bloc.dart';

enum TransactionStatus {
  initial,
  success,
  error,
  loading,
  add,
  remove,
  clear,
  hold,
  pay
}

extension TransactionStatusX on TransactionStatus {
  bool get isInitial => this == TransactionStatus.initial;
  bool get isSuccess => this == TransactionStatus.success;
  bool get isError => this == TransactionStatus.error;
  bool get isLoading => this == TransactionStatus.loading;
  bool get isAdded => this == TransactionStatus.add;
  bool get isRemoved => this == TransactionStatus.remove;
  bool get isCleared => this == TransactionStatus.clear;
  bool get isHeld => this == TransactionStatus.hold;
  bool get isPayed => this == TransactionStatus.pay;
}

class TransactionState extends Equatable {
  TransactionState({
    this.status = TransactionStatus.initial,
    OrderModel? transactionOrderModel,
    String? note,
    double? totalPayment,
    double? dineOption,
  })  : transactionOrderModel = transactionOrderModel ?? OrderModel.empty,
        note = note ?? '',
        dineOption = dineOption ?? 0,
        totalPayment = totalPayment ?? 0;

  final OrderModel transactionOrderModel;
  final String note;
  final double totalPayment;
  final double dineOption;
  final TransactionStatus status;

  @override
  List<Object?> get props => [
        status,
        transactionOrderModel,
        totalPayment,
        note,
        dineOption,
      ];

  TransactionState copyWith({
    OrderModel? transactionOrderModel,
    double? totalPayment,
    String? note,
    double? dineOption,
    TransactionStatus? status,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactionOrderModel:
          transactionOrderModel ?? this.transactionOrderModel,
      note: note ?? this.note,
      totalPayment: totalPayment ?? this.totalPayment,
      dineOption: dineOption ?? this.dineOption,
    );
  }
}
