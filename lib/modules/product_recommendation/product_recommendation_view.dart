import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:ml_product_recommendation/modules/product_list/product_list_controller.dart';
import 'package:ml_product_recommendation/modules/product_list/sliver_list/sliver_grid.dart';
import 'package:ml_product_recommendation/modules/product_list/widget/loading_sliver_app_bar.dart';
import 'package:ml_product_recommendation/modules/product_list/widget/loading_sliver_grid.dart';
import 'package:ml_product_recommendation/utils/state.dart';
import 'package:ml_product_recommendation/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductRecommendation extends StatefulWidget {
  const ProductRecommendation({super.key});
  static const routeName = 'product-recommendation';
  static Route route() {
    return MaterialPageRoute(settings: const RouteSettings(name: routeName), builder: (_) => const ProductRecommendation());
  }

  @override
  State<ProductRecommendation> createState() => _ProductRecommendationState();
}

class _ProductRecommendationState extends State<ProductRecommendation> {
  // final int index = 0;
  Product? data;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<ProductListController>(context, listen: false).getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductListController>(
        builder: (_, value, __) {
          if (value.state == NotifierState.initial) {
            return const CustomScrollView(
              slivers: [LoadingStateSliverGrid()],
            );
          }
          if (value.state == NotifierState.loading) {
            return const CustomScrollView(
              slivers: [LoadingStateSliverGrid()],
            );
          } else if (value.state == NotifierState.loaded) {
            return CustomScrollView(
              slivers: [
                LoadedStateSliverGrid(
                  products: value.products,
                ),
              ],
            );
          } else {
            return const CustomScrollView(
              slivers: [LoadingStateSliverAppBar(), LoadingStateSliverGrid()],
            );
          }
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}
