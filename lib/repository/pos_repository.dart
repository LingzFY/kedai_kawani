import 'package:pos_kawani/repository/models/category_list_model.dart';
import 'package:pos_kawani/repository/models/order_list_model.dart';
import 'package:pos_kawani/repository/models/order_model.dart';
import 'package:pos_kawani/repository/models/product_list_model.dart';
import 'package:pos_kawani/repository/services/pos_service.dart';

class PosRepository {
  const PosRepository({
    required this.service,
  });

  final PosService service;

  Future<OrderModel> getTransactions() => service.getTransactions();

  Future<CategoryListModel> getCategories() async => service.getCategories();

  Future<ProductListModel> getProducts() async => service.getProducts();

  Future<ProductListModel> getProductsByCategory(String idCategory) async => service.getProductsByCategory(idCategory);

  Future<OrderListModel> getHoldOrders(String status) async => service.getHoldOrders(status);
}