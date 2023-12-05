import 'package:thimar/core/logic/helper_methods.dart';

class ForgetPasswordStates{}

class ForgetPasswordLoadingState extends ForgetPasswordStates{}

class ForgetPasswordSuccessState extends ForgetPasswordStates{
  final String message;

  ForgetPasswordSuccessState({required this.message}){
    showMessage(message,type: MessageType.success);

  }
}

class ForgetPasswordFieldState extends ForgetPasswordStates{}