import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ml_product_recommendation/database/key.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static Future init() async {
    Directory path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<Product>(PRODUCT_FAVORITE);
    await Hive.openBox<Product>(PRODUCT_RECOMMENDATION);
  }
}
