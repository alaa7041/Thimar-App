import 'package:thimar/core/logic/helper_methods.dart';

class ConfirmCodeStates{}

class ConfirmCodeLoadingState extends ConfirmCodeStates{}
class ConfirmCodeSuccessState extends ConfirmCodeStates{
  final String message;

  ConfirmCodeSuccessState({required this.message}){
    showMessage(message,type: MessageType.success);
  }
}
class ConfirmCodeFailedState extends ConfirmCodeStates{}