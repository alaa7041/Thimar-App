part of 'bloc.dart';
class StoreItemInCartStates{}

class StoreItemInCartLoadingState extends StoreItemInCartStates {
  final int productId;

  StoreItemInCartLoadingState({required this.productId});
}

class StoreItemInCartSuccessState extends StoreItemInCartStates {
  final ProductModel model;
  StoreItemInCartSuccessState({required this.model});

}

class StoreItemInCartFieldState extends StoreItemInCartStates {
  final String message;

  StoreItemInCartFieldState({required this.message});
}
