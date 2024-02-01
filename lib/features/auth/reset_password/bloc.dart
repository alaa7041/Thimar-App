import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/home/view.dart';

part 'events.dart';
part 'states.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordStates> {
  final DioHelper _dio;

  ResetPasswordBloc(this._dio) : super(ResetPasswordStates()) {
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
      final response = await _dio.sendData("reset_password", data: {
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
