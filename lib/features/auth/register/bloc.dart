import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../views/auth/confirm_code/view.dart';
import '../../get_cities/bloc.dart';
part 'states.dart';
part 'events.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {

  CitiesModel? selectedCity;
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterBloc():super(RegisterStates()){
    on<RegisterEvent> (_register);
  }

  Future<void> _register(RegisterEvent event,Emitter<RegisterStates> emit)
  async {
    if (formKey.currentState!.validate()) {
    }
    final response = await DioHelper().sendData("client_register", data: {
      "fullname": fullNameController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "phone": phoneController.text,
      "country_id": 1,
      "city_id": selectedCity?.id,
    });
    if (response.isSuccess) {
      navigateTo(ConfirmCodeView(
        isActive: true,
        phone: phoneController.text,
      ));
      emit(RegisterSuccessStates(message: "Success"));
    } else {
      showMessage(response.message);
      //emit(RegisterLoadingStates());
    }
  }
}
