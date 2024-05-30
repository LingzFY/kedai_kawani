// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:pos_kawani/repository/models/transaction_file_model.dart';
import 'package:pos_kawani/repository/models/transaction_item_model.dart';

class TransactionOrderModel {
  String? IdTransaction;
  double? DineOption;
  List<TransactionItemModel> Items;
  double? PaymentMethodId;
  double? TotalPayment;
  String? PaymentRefference;
  TransactionFileModel? PaymentFile;

  TransactionOrderModel({
    this.IdTransaction,
    this.DineOption,
    required this.Items,
    this.PaymentMethodId,
    this.TotalPayment,
    this.PaymentRefference,
    this.PaymentFile,
  });

  static final empty = TransactionOrderModel(
    IdTransaction: '',
    DineOption: 0,
    Items: [],
    PaymentMethodId: 0,
    TotalPayment: 0,
    PaymentRefference: '',
    PaymentFile: TransactionFileModel.empty
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IdTransaction': IdTransaction,
      'DineOption': DineOption,
      'Items': Items.map((x) => x.toMap()).toList(),
      'PaymentMethodId': PaymentMethodId,
      'TotalPayment': TotalPayment,
      'PaymentRefference': PaymentRefference,
      'PaymentFile': PaymentFile?.toMap(),
    };
  }

  factory TransactionOrderModel.fromMap(Map<String, dynamic> map) {
    return TransactionOrderModel(
      IdTransaction: map['IdTransaction'] != null ? map['IdTransaction'] as String : null,
      DineOption: map['DineOption'] != null ? map['DineOption'] as double : null,
      Items: List<TransactionItemModel>.from((map['Items'] as List).map<TransactionItemModel>((x) => TransactionItemModel.fromMap(x as Map<String,dynamic>),),),
      PaymentMethodId: map['PaymentMethodId'] != null ? map['PaymentMethodId'] as double : null,
      TotalPayment: map['TotalPayment'] != null ? map['TotalPayment'] as double : null,
      PaymentRefference: map['PaymentRefference'] != null ? map['PaymentRefference'] as String : null,
      PaymentFile: map['PaymentFile'] != null ? TransactionFileModel.fromMap(map['PaymentFile'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionOrderModel.fromJson(String source) =>
      TransactionOrderModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
