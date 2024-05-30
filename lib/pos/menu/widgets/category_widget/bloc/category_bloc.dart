import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/repository/models/category_list_model.dart';
import 'package:pos_kawani/repository/pos_repository.dart';
import 'package:pos_kawani/repository/models/category_model.dart';

part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.posRepository,
  }) : super(const CategoryState()) {
    on<GetCategories>(_mapGetCategoryEventToState);
    on<SelectCategory>(_mapSelectCategoryEventToState);
  }

  final PosRepository posRepository;

  void _mapGetCategoryEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(state.copyWith(status: CategoryStatus.loading));
      CategoryListModel categories = await posRepository.getCategories();
      categories.Items.insert(
        0,
        const CategoryModel(
          Id: '',
          Name: 'All',
        ),
      );
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories.Items,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) async {
    emit(
      state.copyWith(
        status: CategoryStatus.selected,
        idSelected: event.idSelected,
      ),
    );
  }
}
