import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/home/view.dart';
import 'events.dart';
import 'states.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordStates> {
  ResetPasswordBloc() : super(ResetPasswordStates()) {
    on<ResetPasswordEvent>(_reset);
  }

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  Future<void> _reset(ResetPasswordEvent event, Emitter<ResetPasswordStates> emit) async {

    if (formKey.currentState!.validate()) {
      emit(ResetPasswordLoadingState());
      final response = await DioHelper().sendData("reset_password", data: {
        "code": codeController.text,
        "phone": phoneController.text,
        "password": confirmPasswordController.text,
      });
      if (response.isSuccess) {
        emit(ResetPasswordSuccessState(message: "Success"));
        navigateTo(const HomeView());
      } else {
        showMessage(response.message);
        emit(ResetPasswordLoadingState());
      }
    }
  }
}
