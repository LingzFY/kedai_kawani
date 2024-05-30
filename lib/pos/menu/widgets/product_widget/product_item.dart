// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_kawani/repository/models/product_model.dart';

typedef ProductCLicked = Function(ProductModel productSelected);

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.callback});

  final ProductCLicked callback;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(product),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _LoadImage(
                  key: ValueKey(product.Id!),
                  ImageUrl: product.ImageUrl,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              (product.Name == null || product.Name == "")
                  ? "Kedai Kawani's Menu"
                  : product.Name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Text(
              (product.Description == null || product.Description == "")
                  ? "by Kedai Kawani"
                  : product.Description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),
            Text(
              NumberFormat.simpleCurrency(locale: "id-ID").format(
                (product.Price == null || product.Price == 0)
                    ? 0
                    : product.Price!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadImage extends StatelessWidget {
  const _LoadImage({super.key, required this.ImageUrl});

  final String? ImageUrl;

  @override
  Widget build(BuildContext context) {
    return (ImageUrl == null || ImageUrl == "")
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.asset(
              "assets/images/example_image.jpg",
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.network(
              ImageUrl!,
              fit: BoxFit.cover,
            ),
          );
  }
}
