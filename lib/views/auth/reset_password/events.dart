class ResetPasswordEvents{}

class ResetPasswordEvent extends ResetPasswordEvents{
  final String code;
  final String phone;

  ResetPasswordEvent({required this.code, required this.phone});
}