import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pos_kawani/repository/models/category_list_model.dart';
import 'package:pos_kawani/repository/models/order_list_model.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/payment_method_list_model.dart';
import 'package:pos_kawani/repository/models/payment_method_model.dart';
import 'package:pos_kawani/repository/models/product_list_model.dart';
import 'package:pos_kawani/repository/models/result_error.dart';
import 'package:pos_kawani/repository/models/transaction_id_model.dart';
import 'package:pos_kawani/repository/models/transaction_model.dart';

class PosService {
  PosService({
    http.Client? httpClient,
    this.baseUrl = 'http://kawani.api.ilyasin.com',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Uri getUrl({
    required String url,
    Map<String, String>? extraParameters,
  }) {
    Map<String, String> queryParameters = {};
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: queryParameters,
    );
  }

  Map<String, String> getHeaders() {
    String contentType = 'application/json';
    String token = 'Bearer ${dotenv.get('BEARER_TOKEN')}';
    Map<String, String> headers = {
      'Content-Type': contentType,
      'Authorization': token,
    };
    return headers;
  }

  Future<TransactionIdModel> getUsers() async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/user/transaction'),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return TransactionIdModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Transaction ID');
    }
  }

  Future<OrderModel> getTransactions() async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/order/transaction'),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        TransactionIdModel transactionId =
            TransactionIdModel.fromJson(response.body);
        OrderModel transactionOrder = OrderModel.empty;

        transactionOrder.Id = transactionId.Id;
        transactionOrder.TrxNo = transactionId.TrxNo;

        return transactionOrder;
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Transaction ID');
    }
  }

  Future<CategoryListModel> getCategories() async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/category/get'),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return CategoryListModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Categories');
    }
  }

  Future<ProductListModel> getProducts() async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/product/get'),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return ProductListModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Products');
    }
  }

  Future<ProductListModel> getProductsByCategory(String idCategory) async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/product/get', extraParameters: {
        'id_category': idCategory,
      }),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return ProductListModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Products');
    }
  }

  Future<OrderListModel> getHoldOrders(String status) async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/order/list', extraParameters: {
        'status': status,
      }),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return OrderListModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Products');
    }
  }

  Future<int> postHoldOrder(TransactionOrderModel transactionOrderModel) async {
    final response = await _httpClient.post(
      getUrl(url: 'api/v1/order/hold'),
      headers: getHeaders(),
      body: transactionOrderModel.toJson(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.statusCode;
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error hold order');
    }
  }

  
  Future<PaymentMethodListModel> getPaymentMethods() async {
    final response = await _httpClient.get(
      getUrl(url: 'api/v1/PaymentMethod/get'),
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return PaymentMethodListModel.fromJson(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error getting Products');
    }
  }

  Future<int> postPaymentOrder(
      TransactionOrderModel transactionOrderModel) async {
    final response = await _httpClient.post(
      getUrl(url: 'api/v1/order/payment'),
      headers: getHeaders(),
      body: transactionOrderModel.toJson(),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response.statusCode;
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingResponse('Error pay order');
    }
  }
}
