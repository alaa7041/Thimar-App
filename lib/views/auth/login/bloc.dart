import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/cashe_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../home/view.dart';
import 'events.dart';
import 'model.dart';
import 'states.dart';

class LoginBloc extends Bloc<LoginEvents,LoginStates>{
  LoginBloc(super.initialState);
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: "966132847241864");
  final passwordController = TextEditingController(text: "123456789");

  void login() async {
    emit(LoginLodingState());
    if (formKey.currentState!.validate()) {
      login();
      final response = await DioHelper().sendData(
        "login",
        data: {
          "phone": phoneController.text,
          "password": passwordController.text,
          "type": Platform.operatingSystem,
          "device_token": "test",
          "user_type": "client",
        },
      );
      if (response.isSuccess) {
        final model = UserData.fromJson(response.response!.data);
        await CasheHelper.saveUserData(model.model);
        showMessage(response.message, type: MessageType.success);
        navigateTo(HomeView());
        emit(LoginSuccessState());
      }
      else {
        showMessage(response.message);
        emit(LoginFiledState());
      }
    }

  }

}