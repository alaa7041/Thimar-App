
part of 'bloc.dart';

class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String message;

  LoginSuccessState({required this.message}) {
    showMessage(message, type: MessageType.success);
    navigateTo(const HomeView());
  }
}

class LoginFiledState extends LoginStates {
  final String message;

  LoginFiledState({required this.message}) {
    showMessage(message);
  }
}
