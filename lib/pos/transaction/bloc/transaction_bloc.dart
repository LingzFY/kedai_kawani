import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';
import 'package:pos_kawani/repository/pos_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    required this.posRepository,
  }) : super(TransactionState()) {
    on<GetTransactions>(_mapGetTransactionEventToState);
    on<AddTransactionItemList>(_mapAddTransactionItemListEventToState);
    on<RemoveTransactionItemList>(_mapRemoveTransactionItemListEventToState);
    on<AddTransactionItemQty>(_mapAddTransactionItemQtyEventToState);
    on<ReduceTransactionItemQty>(_mapReduceTransactionItemQtyEventToState);
    on<AddTransactionItemNote>(_mapAddTransactionItemNoteEventToState);
    on<ChangeDineOption>(_mapChangeDineOptionEventToState);
  }

  final PosRepository posRepository;

  double setTotalPrice(List<TransactionItemModel> items) {
    double totalPrice = 0;
    if (items.isNotEmpty) {
      for (int index = 0; index < items.length; index++) {
        totalPrice =
            totalPrice + (items[index].Qty! * items[index].Product!.Price!);
      }
    }
    return totalPrice;
  }

  void _mapGetTransactionEventToState(
      GetTransactions event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      OrderModel transactionOrderModel = await posRepository.getTransactions();

      emit(
        state.copyWith(
          status: TransactionStatus.success,
          transactionOrderModel: transactionOrderModel,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapAddTransactionItemListEventToState(
      AddTransactionItemList event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrderModel.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    OrderModel transactionOrderModel = state.transactionOrderModel;
    if (targetIndex == -1) {
      transactionOrderModel.Items.add(event.transactionItemModel);
    }
    transactionOrderModel.TotalPrice =
        setTotalPrice(transactionOrderModel.Items);

    emit(
      TransactionState(
        status: TransactionStatus.add,
        transactionOrderModel: transactionOrderModel,
        totalPayment: transactionOrderModel.TotalPrice,
      ),
    );
  }

  void _mapRemoveTransactionItemListEventToState(
      RemoveTransactionItemList event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrderModel.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    OrderModel transactionOrderModel = state.transactionOrderModel;
    if (targetIndex != -1) {
      transactionOrderModel.Items.remove(event.transactionItemModel);
    }
    transactionOrderModel.TotalPrice =
        setTotalPrice(transactionOrderModel.Items);

    emit(
      TransactionState(
        status: TransactionStatus.remove,
        transactionOrderModel: transactionOrderModel,
        totalPayment: transactionOrderModel.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemQtyEventToState(
      AddTransactionItemQty event, Emitter<TransactionState> emit) async {
    OrderModel transactionOrderModel = state.transactionOrderModel;
    transactionOrderModel.Items[event.targetIndex].Qty =
        transactionOrderModel.Items[event.targetIndex].Qty! + 1;

    transactionOrderModel.TotalPrice =
        setTotalPrice(transactionOrderModel.Items);

    emit(
      TransactionState(
        transactionOrderModel: transactionOrderModel,
        totalPayment: transactionOrderModel.TotalPrice,
      ),
    );
  }

  void _mapReduceTransactionItemQtyEventToState(
      ReduceTransactionItemQty event, Emitter<TransactionState> emit) async {
    OrderModel transactionOrderModel = state.transactionOrderModel;
    if (transactionOrderModel.Items[event.targetIndex].Qty! > 1) {
      transactionOrderModel.Items[event.targetIndex].Qty =
          transactionOrderModel.Items[event.targetIndex].Qty! - 1;
    }

    transactionOrderModel.TotalPrice =
        setTotalPrice(transactionOrderModel.Items);

    emit(
      TransactionState(
        transactionOrderModel: transactionOrderModel,
        totalPayment: transactionOrderModel.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemNoteEventToState(
      AddTransactionItemNote event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrderModel.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    OrderModel transactionOrderModel = state.transactionOrderModel;
    if (targetIndex != -1) {
      transactionOrderModel.Items[targetIndex].Notes = event.newNote;
      transactionOrderModel.Items[targetIndex].Description = event.newNote;
    }

    emit(
      TransactionState(
        transactionOrderModel: transactionOrderModel,
        note: transactionOrderModel.Items[targetIndex].Notes
      ),
    );
  }

  void _mapChangeDineOptionEventToState(
      ChangeDineOption event, Emitter<TransactionState> emit) async {
    OrderModel transactionOrderModel = state.transactionOrderModel;
    transactionOrderModel.DineOption = event.dineOption;

    emit(
      TransactionState(
        transactionOrderModel: transactionOrderModel,
        dineOption: event.dineOption,
      ),
    );
  }
}
