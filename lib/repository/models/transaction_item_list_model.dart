// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:pos_kawani/repository/models/transaction_item_model.dart';

class TransactionItemListModel {
  final List<TransactionItemModel> Items;

  const TransactionItemListModel({
    required this.Items,
  });

  static const empty = TransactionItemListModel(
    Items: [],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Items': Items.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionItemListModel.fromMap(Map<String, dynamic> map) {
    return TransactionItemListModel(
      Items: List<TransactionItemModel>.from(
        (map['Items'] as List<int>).map<TransactionItemModel>(
          (x) => TransactionItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionItemListModel.fromJson(String source) =>
      TransactionItemListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
