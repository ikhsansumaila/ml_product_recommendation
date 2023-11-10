// import package
import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/modules/product_favorite/database/product_favorite.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:ml_product_recommendation/modules/product_list/product_list_controller.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.parentWidth,
    required this.parentHeight,
    required this.product,
    this.isFavorite = false,
  }) : super(key: key);
  final double parentWidth;
  final double parentHeight;
  final Product product;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(
      color: const Color(0xFF9B9B9B),
      blurRadius: parentWidth * 0.001,
      spreadRadius: parentWidth * 0.001,
      offset: Offset(0, parentWidth * 0.005),
    );

    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        width: parentWidth * 0.24,
        height: parentHeight * 0.14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFFFFFF),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: IconButton(
          color: (isFavorite) ? const Color(0xFFDB3022) : const Color(0xFF9B9B9B),
          icon: (isFavorite) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
          onPressed: () => onTap(context),
        ),
      ),
    );
  }

  void onTap(context) async {
    var favorite = !isFavorite;

    // save to local DB
    FavoriteDB.addOrDelete(
        isFavorite: favorite,
        data: Product.fromJson({
          ...product.toJson(),
          'favorite': favorite,
        }));

    // update product list data state
    ProductListController controller = Provider.of<ProductListController>(context, listen: false);
    controller.updateProducts(controller.products.map((e) {
      if (product.id == e.id) {
        e.favorite = favorite;
      }
      return e;
    }).toList());

    for (var e in controller.products) {
      if (product.id == e.id) {
        print('e.title ${e.title} - ${e.favorite}');
      }
    }
  }
}
