class CartData {
  late final List<CartModel> list;
  late final num totalPriceBeforeDiscount;
  late final num totalDiscount;
  late final num totalPriceWithVat;
  late final num deliveryCost;
  late final num freeDeliveryPrice;
  late final double vat;
  late final num isVip;
  late final num vipDiscountPercentage;
  late final num minVipPrice;
  late final String vipMessage;
  late final String status;
  late final String message;

  CartData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => CartModel.fromJson(e))
        .toList();
    totalPriceBeforeDiscount = json['total_price_before_discount']??0;
    totalDiscount = json['total_discount']??0;
    totalPriceWithVat = json['total_price_with_vat']??0;
    deliveryCost = json['delivery_cost']??0;
    freeDeliveryPrice = json['free_delivery_price']??0;
    vat = json['vat']??0;
    isVip = json['is_vip']??0;
    vipDiscountPercentage = json['vip_discount_percentage']??0;
    minVipPrice = json['min_vip_price']??0;
    vipMessage = json['vip_message']??"";
    status = json['status']??"";
    message = json['message']??"";
  }


}

class ProductCart {
  late final String status;
  late final String message;
  late final CartModel data;

  ProductCart.fromJson(Map<String, dynamic> json) {
    status = json['status']??"";
    message = json['message']??"";
    data = CartModel.fromJson(json['data']);
  }
}

class CartModel {
  late final int id;
  late final String title;
  late final String image;
  late final num amount;
  late final num deliveryCost;
  late final num price;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']??'';
    image = json['image']??"";
    amount = json['amount']??0;
    deliveryCost = json['delivery_cost'] ?? 0;
    price = json['price']??0;
  }
}

class SortItemInCartData {

  late final String status;
  late final String message;
  late final List<StoreModel >list;

  SortItemInCartData.fromJson(Map<String, dynamic> json){
    status = json['status']??"";
    message = json['message']??"";
    list = List.from(json['data'] ?? [])
        .map((e) =>  StoreModel.fromJson(e))
        .toList();

  }
}

class StoreModel {
  late final int productId;
  late final String title;
  late final String image;
  late final num amount;
  late final num deliveryCost;
  late final num price;

  StoreModel.fromJson(Map<String, dynamic> json){
    productId = json['product_id'];
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    deliveryCost = json['delivery_cost'];
    price = json['price'];
  }

}