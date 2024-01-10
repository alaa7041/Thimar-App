part of 'bloc.dart';

class ConfirmCodeEvents{}

class ConfirmCodeEvent extends ConfirmCodeEvents{
  final bool isActive;
  final String phone;

  ConfirmCodeEvent({required this.isActive,required this.phone});
}

class ResendCodeEvent extends ConfirmCodeEvents{
  final String phone;

  ResendCodeEvent({required this.phone});
}