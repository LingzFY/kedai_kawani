// ignore_for_file: prefer_initializing_formals

part of 'category_bloc.dart';

enum CategoryStatus { initial, success, error, loading, selected }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSelected => this == CategoryStatus.selected;
}

class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.initial,
    List<CategoryModel>? categories,
    String idSelected = '',
  })  : categories = categories ?? const [],
        idSelected = idSelected;

  final List<CategoryModel> categories;
  final CategoryStatus status;
  final String idSelected;

  @override
  List<Object?> get props => [status, categories, idSelected];

  CategoryState copyWith({
    List<CategoryModel>? categories,
    CategoryStatus? status,
    String? idSelected,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      idSelected: idSelected ?? this.idSelected,
    );
  }
}
