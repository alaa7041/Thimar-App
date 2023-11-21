import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/categories/events.dart';
import 'package:thimar/features/categories/states.dart';
import '../../core/logic/dio_helper.dart';
import 'model.dart';


class CategoriesBloc extends Bloc<CategoriesEvents,CategoriesStates>{
  CategoriesBloc():super(CategoriesStates()){
    on<GetCategoriesEvent> (_getData);
  }

  Future<void> _getData(GetCategoriesEvent event,Emitter<CategoriesStates> emit)
  async {
    emit(CategoriesLoadingState());
    final response = await DioHelper().getData("categories");

    if(response.isSuccess){
      final model = CategoriesData.fromJson(response.response!.data);
      emit(CategoriesSuccessState(list: model.list));
  }else
    {
      emit(CategoriesFailedState(message: "Failed"));
    }
}
}