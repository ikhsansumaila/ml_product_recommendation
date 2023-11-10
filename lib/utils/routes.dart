import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/modules/product_list/product_list_view.dart';
import 'package:ml_product_recommendation/modules/product_recommendation/product_recommendation_view.dart';
import 'package:ml_product_recommendation/modules/product_favorite/product_favorite_view.dart';

class Routes {
  static Map<String, WidgetBuilder> items = {
    ProductListView.routeName: (context) => const ProductListView(),
    ProductWishList.routeName: (context) => const ProductWishList(),
    ProductRecommendation.routeName: (context) => const ProductRecommendation(),
  };
}
