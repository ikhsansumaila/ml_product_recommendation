// import package
// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/modules/product_list/repository/dummy_api.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:ml_product_recommendation/modules/product_favorite/database/product_favorite.dart';
import 'package:ml_product_recommendation/utils/state.dart';

class ProductListController with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void refreshList(List<Product>? products) {
    if (products != null) {
      _setProducts(products);
    } else {
      getProducts();
    }
  }

  void _setProducts(List<Product> products) {
    List<Product> favoriteProductsDB = FavoriteDB.getAll();
    // FavoriteDB.favoriteBox.deleteFromDisk();

    _products = products.map((product) {
      product.favorite =
          favoriteProductsDB.where((productDB) => productDB.id == product.id && productDB.favorite == true).toList().isNotEmpty;
      return product;
    }).toList();
    _products = products;
    notifyListeners();
  }

  void getProducts() async {
    if (_products.isNotEmpty) return;

    _setState(NotifierState.loading);
    try {
      await DummyApi.getProducts().then((value) {
        _setProducts(value);
      }).catchError(() {
        _setState(NotifierState.error);
      });
      _setState(NotifierState.loaded);
    } catch (e) {
      _setState(NotifierState.error);
    }
  }

  void updateProducts(List<Product> newProducts) {
    _products = newProducts;
    notifyListeners();
  }
}
