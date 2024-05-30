import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/category_widget/bloc/category_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/category_widget/category_item.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/bloc/product_bloc.dart';
import 'package:pos_kawani/repository/models/category_model.dart';

class CategorySuccessWidget extends StatelessWidget {
  const CategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.idSelected == '') {
          context.read<CategoryBloc>().add(
                SelectCategory(
                  idSelected: '',
                ),
              );
        }
        return SizedBox(
          height: 48.0,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryItem(
              key: ValueKey(state.categories[index].Id),
              category: state.categories[index],
              callback: (CategoryModel categorySelected) {
                context.read<ProductBloc>().add(
                      GetProducts(idCategory: categorySelected.Id),
                    );
                context.read<CategoryBloc>().add(
                      SelectCategory(
                        idSelected: categorySelected.Id,
                      ),
                    );
              },
            ),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(
              width: 24.0,
            ),
            itemCount: state.categories.length,
          ),
        );
      },
    );
  }
}
