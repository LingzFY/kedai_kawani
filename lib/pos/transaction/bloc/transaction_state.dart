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
  paid,
  failed,
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
  bool get isPaid => this == TransactionStatus.paid;
  bool get isFailed => this == TransactionStatus.failed;
}

class TransactionState extends Equatable {
  TransactionState({
    this.status = TransactionStatus.initial,
    OrderModel? transactionOrderModel,
    String? note,
    double? totalPayment,
    double? dineOption,
    double? paymentMethodId,
    String? paymentMethodName,
    String? paymentRefference,
    TransactionFileModel? transactionFileModel,
    PaymentMethodListModel? paymentMethods,
  })  : transactionOrderModel = transactionOrderModel ?? OrderModel.empty,
        note = note ?? '',
        dineOption = dineOption ?? 0,
        totalPayment = totalPayment ?? 0,
        paymentMethodId = paymentMethodId ?? 0,
        paymentRefference = paymentRefference ?? '',
        paymentMethodName = paymentMethodName ?? '',
        transactionFileModel =
            transactionFileModel ?? TransactionFileModel.empty,
        paymentMethods = paymentMethods ?? PaymentMethodListModel.empty;

  final OrderModel transactionOrderModel;
  final String note;
  final double totalPayment;
  final double dineOption;
  final double paymentMethodId;
  final String paymentRefference;
  final String paymentMethodName;
  final PaymentMethodListModel paymentMethods;
  final TransactionFileModel transactionFileModel;
  final TransactionStatus status;

  @override
  List<Object?> get props => [
        status,
        transactionOrderModel,
        totalPayment,
        note,
        dineOption,
        paymentMethodId,
        paymentRefference,
        paymentMethods,
        paymentMethodName,
      ];

  TransactionState copyWith({
    OrderModel? transactionOrderModel,
    double? totalPayment,
    String? note,
    double? dineOption,
    double? paymentMethodId,
    String? paymentRefference,
    String? paymentMethodName,
    TransactionFileModel? transactionFileModel,
    PaymentMethodListModel? paymentMethods,
    TransactionStatus? status,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactionOrderModel:
          transactionOrderModel ?? this.transactionOrderModel,
      note: note ?? this.note,
      totalPayment: totalPayment ?? this.totalPayment,
      dineOption: dineOption ?? this.dineOption,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentRefference: paymentRefference ?? this.paymentRefference,
      paymentMethodName: paymentMethodName ?? this.paymentMethodName,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      transactionFileModel: transactionFileModel ?? this.transactionFileModel,
    );
  }
}
