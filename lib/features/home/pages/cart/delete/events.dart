part of 'bloc.dart';

class DeleteItemFromCartEvents{}
class DeleteItemFromCartEvent extends DeleteItemFromCartEvents{
  final int id;

  DeleteItemFromCartEvent({required this.id});
}