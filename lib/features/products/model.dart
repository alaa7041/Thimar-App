part of 'bloc.dart';

class ProductsData {
  late final List<ProductModel> list;
  late final num userCartCount,maxPrice,minPrice;


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
  late final int categoryId, id;
  late final String title,description, code;
  late final num priceBeforeDiscount,deliveryCost, price,discount, amount, isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final String mainImage,createdAt;

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id']??0;
    id = json['id']??0;
    title = json['title']??'';
    description = json['description'] ?? "";
    code = json['code'] ?? "";
    priceBeforeDiscount = num.tryParse(json['price_before_discount'].toString()) ?? 0;
    price = num.tryParse(json['price'].toString()) ?? 0;
    deliveryCost = json['delivery_cost'] ?? 0;
    discount = (json['discount'] * 100).truncate() ?? 0;
    amount = json['amount'] ?? 0;
    isActive = json['is_active'] ?? 0;
    isFavorite = json['is_favorite'] ?? false;
    unit = Unit.fromJson(json['unit']??{});
    mainImage = json['main_image']??'';
    createdAt = json['created_at'] ?? "";
  }

  ProductModel.fromMiniJson(Map<String, dynamic> json) {
    id = json['id']??0;
    title = json['title'] ?? '';
    mainImage = json['image'] ?? "";
    amount = json['amount'] ?? 0;
    deliveryCost = json['delivery_cost'] ?? 0;
    price = json['price'] ?? 0;
  }

}

class Unit {
  late final int id;
  late final String name,type, createdAt,updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    type = json['type']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
  }
}

