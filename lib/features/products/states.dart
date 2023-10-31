import 'model.dart';

class ProductsStates{}
class ProductsLoadingState extends ProductsStates{}
class ProductsSuccessState extends ProductsStates{
  final  List<ProductModel> list;

  ProductsSuccessState({required this.list});
}
class ProductsFailedState extends ProductsStates{
  final String msg;

  ProductsFailedState({required this.msg});
}
