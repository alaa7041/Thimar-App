import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../views/home/view.dart';
import 'events.dart';
import 'states.dart';

class ConfirmCodeBloc extends Bloc<ConfirmCodeEvents, ConfirmCodeStates> {
  ConfirmCodeBloc() : super(ConfirmCodeStates()) {
    on<ConfirmCodeEvent>(_verify);
    on<ResendCodeEvent>(_resend);
  }

  bool isPasswordHidden = true;
  bool isTimerFinished = false;

  final codeController = TextEditingController();

  Future<void> _resend(ResendCodeEvent event, Emitter<ConfirmCodeStates> emit) async {
    await DioHelper().sendData("resend_code", data: {
      "phone": event.phone,
    });
  }

  void _verify(ConfirmCodeEvent event, Emitter<ConfirmCodeStates> emit) async {

    emit(ConfirmCodeLoadingState());

    final response = await DioHelper().sendData("verify", data: {
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
