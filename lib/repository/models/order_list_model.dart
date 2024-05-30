// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:pos_kawani/repository/models/order_model.dart';

// FOR
// http://kawani.api.ilyasin.com/api/v1/Order/list

class OrderListModel {
  final int? Count;
  final int? Filtered;
  final List<OrderModel> Items;
  final int? Code;
  final bool? Successed;
  final String? Message;
  final String? Description;

  const OrderListModel({
    required this.Count,
    required this.Filtered,
    required this.Items,
    required this.Code,
    required this.Successed,
    required this.Message,
    required this.Description,
  });

  static const empty = OrderListModel(
    Count: 0,
    Filtered: 0,
    Items: [],
    Code: 0,
    Successed: false,
    Message: 'Message',
    Description: 'Description',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Count': Count,
      'Filtered': Filtered,
      'Items': Items.map((x) => x.toMap()).toList(),
      'Code': Code,
      'Successed': Successed,
      'Message': Message,
      'Description': Description,
    };
  }

  factory OrderListModel.fromMap(Map<String, dynamic> map) {
    return OrderListModel(
      Count: map['Count'] != null ? map['Count'] as int : null,
      Filtered: map['Filtered'] != null ? map['Filtered'] as int : null,
      Items: List<OrderModel>.from(
        (map['List'] as List).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      Code: map['Code'] != null ? map['Code'] as int : null,
      Successed: map['Successed'] != null ? map['Successed'] as bool : null,
      Message: map['Message'] != null ? map['Message'] as String : null,
      Description:
          map['Description'] != null ? map['Description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderListModel.fromJson(String source) =>
      OrderListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
