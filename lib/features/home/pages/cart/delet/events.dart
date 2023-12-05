import '../events.dart';

class DeleteItemFromCartEvent extends CartEvents{
  final int id;

  DeleteItemFromCartEvent({required this.id});
}