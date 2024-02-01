import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/home/view.dart';

part 'events.dart';
part 'states.dart';



class ConfirmCodeBloc extends Bloc<ConfirmCodeEvents, ConfirmCodeStates> {
  final DioHelper _dio;
  ConfirmCodeBloc(this._dio) : super(ConfirmCodeStates()) {
    on<ConfirmCodeEvent>(_verify);
    on<ResendCodeEvent>(_resend);
  }

  bool isPasswordHidden = true;
  bool isTimerFinished = false;

  final codeController = TextEditingController();

  Future<void> _resend(ResendCodeEvent event, Emitter<ConfirmCodeStates> emit) async {
    await _dio.sendData("resend_code", data: {
      "phone": event.phone,
    });
  }

  void _verify(ConfirmCodeEvent event, Emitter<ConfirmCodeStates> emit) async {

    emit(ConfirmCodeLoadingState());

    final response = await _dio.sendData("verify", data: {
      "code": codeController.text,
      "phone": event.phone,
      "type": Platform.operatingSystem,
      "device_token": "test",
    });

    if (response.isSuccess) {
      navigateTo(const HomeView());
      emit(ConfirmCodeSuccessState(message: "Success"));

    } else {
      showMessage(response.message);
      emit(ConfirmCodeFailedState());
    }
  }
}
