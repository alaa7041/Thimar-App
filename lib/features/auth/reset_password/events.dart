part of 'bloc.dart';
class ResetPasswordEvents{}

class ResetPasswordEvent extends ResetPasswordEvents{
  final String code,phone;

  ResetPasswordEvent({required this.code, required this.phone});
}