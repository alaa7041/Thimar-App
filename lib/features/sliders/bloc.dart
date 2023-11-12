import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/sliders/events.dart';
import '../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';


class SliderBloc extends Bloc<SlidersEvents,SliderStates> {
  SliderBloc() : super(SliderStates()){
    on<GetSliderDataEvent> (_getSliderDataImages);
  }



  Future<void> _getSliderDataImages(GetSliderDataEvent event,Emitter<SliderStates> emit)
  async {
    emit(SliderLoadingState());
    final response = await DioHelper().getData("sliders");
    if (response.isSuccess) {
      final model = SliderData.fromJson(response.response!.data);
      emit(SliderSuccessState(list: model.list));
    } else {
      emit(SliderFailedState(msg: response.message));
    }
  }
}
