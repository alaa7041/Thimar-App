
import '../get/bloc.dart';

class StoreItemInCartStates{}

class StoreItemInCartLoadingState extends StoreItemInCartStates {
  final int productId;

  StoreItemInCartLoadingState({required this.productId});
}

class StoreItemInCartSuccessState extends StoreItemInCartStates {
  final List<StoreModel> list;

  StoreItemInCartSuccessState({required this.list});

}

class StoreItemInCartFieldState extends StoreItemInCartStates {
  final String message;

  StoreItemInCartFieldState({required this.message});
}
