import '../events.dart';

class StoreItemInCartEvent extends CartEvents{
  final int amount,productId;

  StoreItemInCartEvent({required this.amount,required this.productId});

}