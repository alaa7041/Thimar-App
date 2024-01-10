import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';
import '../../core/logic/dio_helper.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class GetCitiesBloc extends Bloc<CitiesEvents,GetCitiesStates>{
  GetCitiesBloc(GetCitiesStates getCitiesStates):super(GetCitiesStates()){
    on<GetCitiesEvent> (_getData);
  }


  void _getData(GetCitiesEvent event,Emitter<GetCitiesStates> emit) async {
    emit(GetCitiesLoadingState());

    final response = await DioHelper().getData("cities/1");
    if (response.isSuccess) {
      final model = GetCities.fromJson(response.response!.data);

      emit(GetCitiesSuccessState(list: model.list,message: "message"));
    }
    else {
      emit(GetCitiesFailedState());
    }

  }

}