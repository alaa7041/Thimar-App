class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents{
  final String phone;

  ForgetPasswordEvent({required this.phone});
}