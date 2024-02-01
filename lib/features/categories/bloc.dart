import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/categories/events.dart';

import '../../core/logic/dio_helper.dart';

part 'model.dart';
part 'states.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesStates> {
  final DioHelper _dio;
  CategoriesBloc(this._dio) : super(CategoriesStates()) {
    on<GetCategoriesEvent>(_getData);
  }

  Future<void> _getData(
      GetCategoriesEvent event, Emitter<CategoriesStates> emit) async {
    emit(CategoriesLoadingState());
    final response = await _dio.getData("categories");

    if (response.isSuccess) {
      final model = CategoriesData.fromJson(response.response!.data);
      emit(CategoriesSuccessState(list: model.list));
    } else {
      emit(CategoriesFailedState(message: response.message));
    }
  }
}
