import 'package:flutter/material.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/get_cities/model.dart';
import '../confirm_code/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  CitiesModel? selectedCity;
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterBloc(super.initialState);

  void register() async {
    if (formKey.currentState!.validate()) {
    }
    final response = await DioHelper().sendData("client_register", data: {
      "fullname": fullNameController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "phone": phoneController.text,
      "country_id": 1,
      "city_id": selectedCity!.id,
    });
    if (response.isSuccess) {
      showMessage(response.message, type: MessageType.success);
      navigateTo(ConfirmCodeView(
        isActive: true,
        phone: phoneController.text,
      ));
      emit(RegisterSuccessStates());
    } else {
      showMessage(response.message);
      emit(RegisterLoadingStates());
    }
  }
}
