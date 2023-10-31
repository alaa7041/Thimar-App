import 'package:flutter/material.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../confirm_code/view.dart';
import 'events.dart';
import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      emit(ForgetPasswordSuccessState());
    } else {
      showMessage(response.message);
      emit(ForgetPasswordFieldState());
    }
  }
}
