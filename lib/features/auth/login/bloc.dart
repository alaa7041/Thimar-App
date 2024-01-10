import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/home/view.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginStates()) {
    on<LoginEvent>(_login);
  }

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login(LoginEvent event, Emitter<LoginStates> emit) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
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

        await CacheHelper.saveUserData(model.model);
        emit(LoginSuccessState(message: response.message));
      } else {
        emit(LoginFiledState(message: response.message));
      }
    }
  }
}
