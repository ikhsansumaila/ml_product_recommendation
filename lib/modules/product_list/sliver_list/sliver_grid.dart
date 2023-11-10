import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:ml_product_recommendation/modules/product_list/sliver_list/product_item/product_item.dart';

class LoadedStateSliverGrid extends StatelessWidget {
  const LoadedStateSliverGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          return ProductItem(product: products[index]);
        }), childCount: products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.73,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
