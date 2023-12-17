
class StoreItemInCartEvents{}

class StoreItemInCartEvent extends StoreItemInCartEvents{
  final int amount,productId;

  StoreItemInCartEvent({required this.amount,required this.productId});

}