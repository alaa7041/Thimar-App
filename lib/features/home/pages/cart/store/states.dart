import '../../../../../features/home/pages/cart/states.dart';
import '../model.dart';

class StoreItemInCartLoadingState extends CartStates {
  final int productId;

  StoreItemInCartLoadingState({required this.productId});
}

class StoreItemInCartSuccessState extends CartStates {
  final List<StoreModel> list;

  StoreItemInCartSuccessState({required this.list});
}

class StoreItemInCartFieldState extends CartStates {
  final String message;

  StoreItemInCartFieldState({required this.message});
}
