import '../events.dart';

class UpdateItemInCartEvent extends CartEvents{
  final int id,amount;

  UpdateItemInCartEvent({required this.id,required this.amount});

}