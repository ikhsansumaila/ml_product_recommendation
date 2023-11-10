// import package
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ml_product_recommendation/models/category.dart';
import 'package:ml_product_recommendation/models/failure.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';

class DummyApi {
  static Future<List<Product>> getProducts() async {
    Uri url = Uri.parse('https://dummyjson.com/products');
    try {
      var response = await http.get(url);
      List data = json.decode(response.body)['products'];
      return data.map((e) => Product.fromJson(e)).toList();
    } on SocketException catch (_) {
      throw Failure(message: 'There is no internet connection.\n Please check your data roaming.');
    } on HttpException catch (e) {
      throw Failure(message: 'Oopss!!!\n$e.message');
    } catch (e) {
      throw Failure(message: 'Error!!!\n$e.message');
    }
  }

  static Future getProduct(int productId) async {
    Uri url = Uri.parse('https://dummyjson.com/products/$productId');
    var response = await http.get(url);
    try {
      Product product = Product.fromJson(json.decode(response.body));
      return product;
    } on SocketException catch (e) {
      throw Failure(message: 'There is no internet connection.\n Please check your data roaming.\n${e.toString()}');
    } on HttpException catch (e) {
      throw Failure(message: '${response.statusCode}\n${e.toString()}');
    }
  }

  static Future getCategories() async {
    Uri url = Uri.parse('https://dummyjson.com/products/categories');
    var response = await http.get(url);
    try {
      List categories = json.decode(response.body);
      return categories.map((e) => Category(name: e)).toList();
    } on SocketException catch (e) {
      throw Failure(message: 'There is no internet connection.\n Please check your data roaming.\n${e.toString()}');
    } on HttpException catch (e) {
      throw Failure(message: '${response.statusCode}\n${e.toString()}');
    }
  }
}
