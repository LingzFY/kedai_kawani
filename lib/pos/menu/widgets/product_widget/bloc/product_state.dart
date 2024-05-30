part of 'product_bloc.dart';

enum ProductStatus { initial, success, error, loading }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isSuccess => this == ProductStatus.success;
  bool get isError => this == ProductStatus.error;
  bool get isLoading => this == ProductStatus.loading;
}

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    ProductListModel? products,
    String? idCategory,
  })  : products = products ?? ProductListModel.empty,
        idCategory = idCategory ?? '';

  final ProductListModel products;
  final ProductStatus status;
  final String idCategory;

  @override
  List<Object?> get props => [status, products, idCategory];

  ProductState copyWith({
    ProductListModel? products,
    ProductStatus? status,
    String? idCategory,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      idCategory: idCategory ?? this.idCategory,
    );
  }
}
