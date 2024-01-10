part of 'bloc.dart';

class UpdateItemInCartEvents{}
class UpdateItemInCartEvent extends UpdateItemInCartEvents{
  final int id,amount;

  UpdateItemInCartEvent({required this.id,required this.amount});

}