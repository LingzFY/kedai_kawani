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