import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_kawani/pos/menu/widgets/category_widget/bloc/category_bloc.dart';
import 'package:pos_kawani/repository/models/category_model.dart';

typedef CategoryCLicked = Function(CategoryModel categorySelected);

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.category, required this.callback});

  final CategoryModel category;
  final CategoryCLicked callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(category),
      child: BlocSelector<CategoryBloc, CategoryState, bool>(
        selector: (state) =>
            (state.status.isSelected && state.idSelected == category.Id)
                ? true
                : false,
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.fromLTRB(8.0, 0, 24, 0),
            decoration: BoxDecoration(
              color: state ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (category.ImageUrl == null || category.ImageUrl == '')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/example_image.jpg',
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          category.ImageUrl!,
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.Name!,
                      style:
                          TextStyle(color: state ? Colors.white : Colors.black),
                    ),
                    if (category.Items != null)
                      Text(
                        '${category.Items!.toString()} items',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
