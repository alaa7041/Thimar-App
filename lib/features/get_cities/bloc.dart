import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/get_cities/states.dart';
import '../../core/logic/dio_helper.dart';
import 'events.dart';
import 'model.dart';

class GetCitiesBloc extends Bloc<CitiesEvents,GetCitiesStates>{
  GetCitiesBloc(GetCitiesStates getCitiesStates):super(GetCitiesStates()){
    on<GetCitiesEvent> (_getData);
  }


  void _getData(GetCitiesEvent event,Emitter<GetCitiesStates> emit) async {
    emit(GetCitiesLoadingState());

    final response = await DioHelper().getData("cities/1");
    if (response.isSuccess) {
      final model = GetCities.fromJson(response.response!.data);

      emit(GetCitiesSuccessState(list: model.list));
    }
    else {
      emit(GetCitiesFailedState());
    }

  }

}