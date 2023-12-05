import '../../../core/logic/helper_methods.dart';

class ResetPasswordStates{}

class ResetPasswordSuccessState extends ResetPasswordStates{
  final String message;

  ResetPasswordSuccessState({required this.message}){
    showMessage(message, type: MessageType.success);
  }
}
class ResetPasswordLoadingState extends ResetPasswordStates{
}
class ResetPasswordFieldState extends ResetPasswordStates{}