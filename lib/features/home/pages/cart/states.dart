
import 'package:thimar/core/logic/helper_methods.dart';

import 'model.dart';

class CartStates{

}

class CartLoadingState extends CartStates{}
class CartSuccessState extends CartStates{
  final List<CartModel> list;
  final String message;

  CartSuccessState({required this.message,required this.list}){
    showMessage(message, type: MessageType.success);
  }
}
class CartFieldState extends CartStates{
  final String message;

  CartFieldState({required this.message});
}


