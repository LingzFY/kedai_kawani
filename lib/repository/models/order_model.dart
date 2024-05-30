// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:pos_kawani/repository/models/transaction_item_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderModel {
  String? Id;
  String? TrxNo;
  String? Description;
  double? SubTotal;
  double? Tax;
  double? TotalPrice;
  double? DineOption;
  String? Status;
  String? CreateBy;
  String? CreateDate;
  String? UpdateBy;
  String? UpdateDate;
  final List<TransactionItemModel> Items;

  OrderModel({
    this.Id,
    this.TrxNo,
    this.Description,
    this.SubTotal,
    this.Tax,
    this.TotalPrice,
    this.DineOption,
    this.Status,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
    required this.Items,
  });

  static final empty = OrderModel(
    Id: '',
    TrxNo: '',
    Description: '',
    SubTotal: 0,
    Tax: 0,
    TotalPrice: 0,
    DineOption: 0,
    Status: '',
    CreateBy: '',
    CreateDate: '',
    UpdateBy: '',
    UpdateDate: '',
    Items: [],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'TrxNo': TrxNo,
      'Description': Description,
      'SubTotal': SubTotal,
      'Tax': Tax,
      'TotalPrice': TotalPrice,
      'DineOption': DineOption,
      'Status': Status,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
      'Items': Items.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      TrxNo: map['TrxNo'] != null ? map['TrxNo'] as String : null,
      Description:
          map['Description'] != null ? map['Description'] as String : null,
      SubTotal: map['SubTotal'] != null ? map['SubTotal'] as double : null,
      Tax: map['Tax'] != null ? map['Tax'] as double : null,
      TotalPrice:
          map['TotalPrice'] != null ? map['TotalPrice'] as double : null,
      DineOption:
          map['DineOption'] != null ? map['DineOption'] as double : null,
      Status: map['Status'] != null ? map['Status'] as String : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate:
          map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate:
          map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
      Items: List<TransactionItemModel>.from(
        (map['Items'] as List).map<TransactionItemModel>(
          (x) => TransactionItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
