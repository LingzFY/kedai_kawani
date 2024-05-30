import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/repository/pos_repository.dart';
import 'package:pos_kawani/repository/models/product_list_model.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.posRepository,
  }) : super(const ProductState()) {
    on<GetProducts>(_mapGetProductEventToState);
  }

  final PosRepository posRepository;

  void _mapGetProductEventToState(
      GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      final products = await posRepository.getProductsByCategory(event.idCategory);
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ProductStatus.error));
    }
  }
}