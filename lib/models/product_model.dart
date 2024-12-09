import 'package:ecom_admin/models/category_model.dart';

class ProductModel {
  String? id;
  CategoryModel categoryModel;
  String productName;
  num price;
  num stock;
  String description;
  String imageUrl;
  bool available;double avrRating;
  int discountPercent;

  ProductModel({
    this.id,
    required this.categoryModel,
    required this.productName,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageUrl,
    this.available = true,
    this.avrRating = 0.0,
    this.discountPercent = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryModel':categoryModel.toMap(),
      'productName': productName,
      'price': price,
      'stock': stock,
      'description': description,
      'imageUrl': imageUrl,
      'available': available,
      'avrRating': avrRating,
      'discountPercent': discountPercent,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      categoryModel: CategoryModel.fromMap(map['categoryModel']),
      productName: map['productName'],
      price: map['price'],
      stock: map['stock'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      available: map['available'],
      avrRating: map['avrRating'],
      discountPercent: map['discountPercent'],
    );
  }
}