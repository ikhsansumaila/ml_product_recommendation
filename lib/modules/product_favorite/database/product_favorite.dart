import 'package:hive/hive.dart';
import 'package:ml_product_recommendation/database/key.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';

class FavoriteDB {
  static Box<Product> favoriteBox = Hive.box(PRODUCT_RECOMMENDATION);

  static List<Product> getAll() {
    return favoriteBox.values.toList();
  }

  static void addOrDelete({required bool isFavorite, required Product data}) {
    if (isFavorite) {
      favoriteBox.put(data.id, data);
    } else {
      favoriteBox.delete(data.id);
    }
  }
}
