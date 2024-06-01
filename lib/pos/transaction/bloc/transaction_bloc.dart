import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/payment_method_list_model.dart';
import 'package:pos_kawani/repository/models/transaction_file_model.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';
import 'package:pos_kawani/repository/models/transaction_model.dart';
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
    //Transaction Section
    // on<SetTransaction>(_mapSetTransactionEventToState);
    on<SetTotalPayment>(_mapSetTotalPaymentEventState);
    on<SetPaymentMethod>(_mapSetPaymentMethodEventState);
    on<SetPaymentFile>(_mapSetPaymentFileEventState);
    on<PostHoldOrder>(_mapPostHoldOrderEventState);
    on<PaymentOrder>(_mapPostPaymentOrderEventState);
    on<GetPaymentMethods>(_mapGetPaymentMethodsEventToState);
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
      OrderModel orderModel = await posRepository.getTransactions();
      orderModel.Items = [];
      orderModel.TotalPrice = setTotalPrice(orderModel.Items);

      emit(
        state.copyWith(
          status: TransactionStatus.success,
          transactionOrderModel: orderModel,
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
    OrderModel orderModel = state.transactionOrderModel;
    if (targetIndex == -1) {
      orderModel.Items.add(event.transactionItemModel);
    }
    orderModel.TotalPrice = setTotalPrice(orderModel.Items);

    emit(
      TransactionState(
        status: TransactionStatus.add,
        transactionOrderModel: orderModel,
        totalPayment: orderModel.TotalPrice,
      ),
    );
  }

  void _mapRemoveTransactionItemListEventToState(
      RemoveTransactionItemList event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrderModel.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    OrderModel orderModel = state.transactionOrderModel;
    if (targetIndex != -1) {
      orderModel.Items.remove(event.transactionItemModel);
    }
    orderModel.TotalPrice = setTotalPrice(orderModel.Items);

    emit(
      TransactionState(
        status: TransactionStatus.remove,
        transactionOrderModel: orderModel,
        totalPayment: orderModel.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemQtyEventToState(
      AddTransactionItemQty event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;
    orderModel.Items[event.targetIndex].Qty =
        orderModel.Items[event.targetIndex].Qty! + 1;

    orderModel.TotalPrice = setTotalPrice(orderModel.Items);

    emit(
      TransactionState(
        transactionOrderModel: orderModel,
        totalPayment: orderModel.TotalPrice,
      ),
    );
  }

  void _mapReduceTransactionItemQtyEventToState(
      ReduceTransactionItemQty event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;
    if (orderModel.Items[event.targetIndex].Qty! > 1) {
      orderModel.Items[event.targetIndex].Qty =
          orderModel.Items[event.targetIndex].Qty! - 1;
    }

    orderModel.TotalPrice = setTotalPrice(orderModel.Items);

    emit(
      TransactionState(
        transactionOrderModel: orderModel,
        totalPayment: orderModel.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemNoteEventToState(
      AddTransactionItemNote event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrderModel.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    OrderModel orderModel = state.transactionOrderModel;
    if (targetIndex != -1) {
      orderModel.Items[targetIndex].Notes = event.newNote;
      orderModel.Items[targetIndex].Description = event.newNote;
    }

    emit(
      TransactionState(
          transactionOrderModel: orderModel,
          note: orderModel.Items[targetIndex].Notes),
    );
  }

  void _mapChangeDineOptionEventToState(
      ChangeDineOption event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;
    orderModel.DineOption = event.dineOption;

    emit(
      TransactionState(
        transactionOrderModel: orderModel,
        dineOption: event.dineOption,
      ),
    );
  }

  // Transaction Section
  // void _mapSetTransactionEventToState(
  //     SetTransaction event, Emitter<TransactionState> emit) async {
  //   OrderModel orderModel = state.transactionOrderModel;

  //   emit(
  //     state.copyWith(
  //       status: TransactionStatus.success,
  //       transactionOrderModel: orderModel,
  //       paymentMethodId: 0,
  //       paymentRefference: '',
  //       totalPayment: 0,
  //     ),
  //   );
  // }

  void _mapSetTotalPaymentEventState(
      SetTotalPayment event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;

    emit(
      state.copyWith(
        status: TransactionStatus.success,
        transactionOrderModel: orderModel,
        paymentMethodId: state.paymentMethodId,
        paymentRefference: state.paymentRefference,
        transactionFileModel: TransactionFileModel.empty,
        totalPayment: event.totalPayment,
      ),
    );
  }

  void _mapSetPaymentMethodEventState(
      SetPaymentMethod event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;

    emit(
      state.copyWith(
        status: TransactionStatus.success,
        transactionOrderModel: orderModel,
        paymentMethodId: event.paymentMethodId,
        paymentRefference: event.paymentRefference,
        transactionFileModel: state.transactionFileModel,
        totalPayment: state.totalPayment,
      ),
    );
  }

  void _mapSetPaymentFileEventState(
      SetPaymentFile event, Emitter<TransactionState> emit) async {
    OrderModel orderModel = state.transactionOrderModel;

    emit(
      state.copyWith(
        status: TransactionStatus.success,
        transactionOrderModel: orderModel,
        paymentMethodId: state.paymentMethodId,
        paymentRefference: state.paymentRefference,
        transactionFileModel: event.transactionFileModel,
        totalPayment: state.totalPayment,
      ),
    );
  }

  void _mapPostHoldOrderEventState(
      PostHoldOrder event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      int responseCode =
          await posRepository.postHoldOrder(event.transactionOrderModel);
      OrderModel orderModel = OrderModel.empty;

      if (responseCode == 200) {
        orderModel = await posRepository.getTransactions();
        orderModel.Items = [];
        orderModel.TotalPrice = setTotalPrice(orderModel.Items);
        emit(
          state.copyWith(
            status: TransactionStatus.hold,
            transactionOrderModel: orderModel,
          ),
        );
      } else {
        orderModel = state.transactionOrderModel;
        orderModel.TotalPrice = setTotalPrice(orderModel.Items);
        emit(
          state.copyWith(
            status: TransactionStatus.failed,
            transactionOrderModel: orderModel,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapGetPaymentMethodsEventToState(
      GetPaymentMethods event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));
      OrderModel orderModel = state.transactionOrderModel;
      PaymentMethodListModel paymentMethods =
          await posRepository.getPaymentMethods();

      emit(
        state.copyWith(
          status: TransactionStatus.success,
          transactionOrderModel: orderModel,
          paymentMethods: paymentMethods,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapPostPaymentOrderEventState(
      PaymentOrder event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      int responseCode =
          await posRepository.postPaymentOrder(event.transactionOrderModel);
      OrderModel orderModel = OrderModel.empty;

      if (responseCode == 200) {
        orderModel = await posRepository.getTransactions();
        orderModel.Items = [];
        orderModel.TotalPrice = setTotalPrice(orderModel.Items);
        emit(
          state.copyWith(
            status: TransactionStatus.paid,
            transactionOrderModel: orderModel,
          ),
        );
      } else {
        orderModel = state.transactionOrderModel;
        orderModel.TotalPrice = setTotalPrice(orderModel.Items);
        emit(
          state.copyWith(
            status: TransactionStatus.failed,
            transactionOrderModel: orderModel,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }
}
