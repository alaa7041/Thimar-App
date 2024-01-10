import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/auth/confirm_code/view.dart';
part 'states.dart';
part 'events.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordStates> {
  ForgetPasswordBloc() : super(ForgetPasswordStates()) {
    on<ForgetPasswordEvent> (forget);
  }

}

final formKey = GlobalKey<FormState>();
final phoneController = TextEditingController();

Future<void> forget(ForgetPasswordEvent event, Emitter<ForgetPasswordStates> emit) async {

  if (formKey.currentState!.validate()) {
    emit(ForgetPasswordLoadingState());

    final response = await DioHelper()
        .sendData("forget_password", data: {

      "phone": event.phone,

    });
    print(response.response!.data);
    if (response.isSuccess) {
      navigateTo(
          ConfirmCodeView(phone: event.phone, isActive: false));
      emit(ForgetPasswordSuccessState(message: "Success"));
    } else {
      showMessage(response.message);
      emit(ForgetPasswordFieldState());
    }
  }
}
