part of 'bloc.dart';

class ProductsData {
  late final List<ProductModel> list;

  late final double userCartCount,maxPrice,minPrice;


  ProductsData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ProductModel.fromJson(e))
        .toList();
    userCartCount = double.tryParse(json['user_cart_count'].toString())??0;
    maxPrice = double.tryParse(json['max_price'].toString()) ?? 0;
    minPrice = double.tryParse(json['min_price'].toString()) ?? 0;
  }
}

class ProductModel {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final num priceBeforeDiscount;
  late final num price;
  late final num discount;
  late final num amount;
  late final num isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'] ?? "";
    code = json['code'] ?? "";
    priceBeforeDiscount =
        num.tryParse(json['price_before_discount'].toString()) ?? 0;
    price = num.tryParse(json['price'].toString()) ?? 0;
    discount = (json['discount'] * 100).truncate() ?? 0;
    amount = json['amount'] ?? 0;
    isActive = json['is_active'] ?? 0;
    isFavorite = json['is_favorite'] ?? 0;
    unit = Unit.fromJson(json['unit']);
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    mainImage = json['main_image'] ?? "";
    createdAt = json['created_at'] ?? "";
  }
}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
