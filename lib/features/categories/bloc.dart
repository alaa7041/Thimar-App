import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/categories/events.dart';
import 'package:thimar/features/categories/states.dart';
import '../../core/logic/dio_helper.dart';
import 'model.dart';


class CategoriesBloc extends Bloc<CategoriesEvents,CategoriesStates>{
  CategoriesBloc(CategoriesStates categoriesStates):super(CategoriesStates()){
    on<CategoriesEvent> (_getData);
  }

  Future<void> _getData(CategoriesEvent event,Emitter<CategoriesStates> emit)  
  async {
    emit(CategoriesLoadingState());
    final response = await DioHelper().getData("categories");

    if(response.isSuccess){
      final model = CategoriesData.fromJson(response.response!.data);
      emit(CategoriesSuccessState(list: model.list));
  }
}
}