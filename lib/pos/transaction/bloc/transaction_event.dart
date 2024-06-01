part of 'transaction_bloc.dart';

class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTransactions extends TransactionEvent {}

class AddTransactionItemList extends TransactionEvent {
  AddTransactionItemList({
    required this.transactionItemModel,
  });

  final TransactionItemModel transactionItemModel;

  @override
  List<Object?> get props => [transactionItemModel];
}

class RemoveTransactionItemList extends TransactionEvent {
  RemoveTransactionItemList({
    required this.transactionItemModel,
  });

  final TransactionItemModel transactionItemModel;

  @override
  List<Object?> get props => [transactionItemModel];
}

class AddTransactionItemQty extends TransactionEvent {
  AddTransactionItemQty({
    required this.targetIndex,
    required this.transactionItemModel,
  });

  final int targetIndex;
  final TransactionItemModel transactionItemModel;

  @override
  List<Object?> get props => [transactionItemModel];
}

class ReduceTransactionItemQty extends TransactionEvent {
  ReduceTransactionItemQty({
    required this.targetIndex,
    required this.transactionItemModel,
  });

  final int targetIndex;
  final TransactionItemModel transactionItemModel;

  @override
  List<Object?> get props => [transactionItemModel];
}

class AddTransactionItemNote extends TransactionEvent {
  AddTransactionItemNote({
    required this.newNote,
    required this.transactionItemModel,
  });
  final TransactionItemModel transactionItemModel;
  final String newNote;

  @override
  List<Object?> get props => [transactionItemModel, newNote];
}

class ChangeDineOption extends TransactionEvent {
  ChangeDineOption({
    required this.dineOption,
  });
  final double dineOption;

  @override
  List<Object?> get props => [dineOption];
}

class PostHoldOrder extends TransactionEvent {
  PostHoldOrder({
    required this.transactionOrderModel,
  });
  final TransactionOrderModel transactionOrderModel;

  @override
  List<Object?> get props => [transactionOrderModel];
}

class GetPaymentMethods extends TransactionEvent {}

class SetTransaction extends TransactionEvent {}

class SetTotalPayment extends TransactionEvent {
  SetTotalPayment({
    required this.totalPayment,
  });
  final double totalPayment;

  @override
  List<Object?> get props => [totalPayment];
}

class SetPaymentMethod extends TransactionEvent {
  SetPaymentMethod({
    required this.paymentMethodId,
    required this.paymentRefference,
  });
  final double paymentMethodId;
  final String paymentRefference;

  @override
  List<Object?> get props => [paymentMethodId, paymentRefference];
}

class SetPaymentFile extends TransactionEvent {
  SetPaymentFile({
    required this.transactionFileModel,
  });
  final TransactionFileModel transactionFileModel;

  @override
  List<Object?> get props => [transactionFileModel];
}

class SelectPaymentMethod extends TransactionEvent {
  SelectPaymentMethod({
    required this.paymentMethodId,
    required this.paymentRefference,
  });
  final double paymentMethodId;
  final String paymentRefference;

  @override
  List<Object?> get props => [paymentMethodId, paymentRefference];
}

class PaymentOrder extends TransactionEvent {
  PaymentOrder({
    required this.transactionOrderModel,
  });
  final TransactionOrderModel transactionOrderModel;

  @override
  List<Object?> get props => [transactionOrderModel];
}
