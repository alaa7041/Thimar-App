part of 'bloc.dart';
class RegisterStates{}

class RegisterLoadingStates extends  RegisterStates{}
class RegisterSuccessStates extends  RegisterStates{
  final String message;

  RegisterSuccessStates({required this.message}){
    showMessage(message, type: MessageType.success);
  }
}
class RegisterFieldStates extends  RegisterStates{}
