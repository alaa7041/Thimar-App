import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';


class SliderCubit extends Cubit<SliderStates> {
  SliderCubit() : super(SliderStates());



  Future<void> getSliderDataImages() async {
    emit(SliderLoadingState());
    final response = await DioHelper().getData("sliders");
    print(response.response?.data);
    if (response.isSuccess) {
      final model = SliderData.fromJson(response.response!.data);
      emit(SliderSuccessState(list: model.list));
    } else {
      emit(SliderFailedState(msg: response.message));
    }
  }
}
