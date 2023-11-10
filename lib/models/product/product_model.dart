import 'package:hive/hive.dart';
import 'package:ml_product_recommendation/utils/dummy_values.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? brand;

  @HiveField(3)
  String? category;

  @HiveField(4)
  num price;

  @HiveField(5)
  String images;

  @HiveField(6)
  bool? favorite;

  Product({
    required this.id,
    required this.title,
    this.brand,
    this.category,
    required this.price,
    required this.images,
    this.favorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        brand: json['brand'],
        category: json['category'],
        price: json['price'],
        images: (json['category'] == 'smartphones')
            ? electronics[json['id']]
            : (json['category'] == 'groceries')
                ? mensClothing[json['id']]
                : womensClothing[json['id']],
        favorite: json['favorite'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'brand': brand,
        'category': category,
        'price': price,
        'images': images,
        'favorite': favorite,
      };
}
