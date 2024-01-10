import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class ProductBloc extends Bloc<ProductEvents,ProductsStates>{
  ProductBloc():super(ProductsStates()){
    on<ProductEvent>(_getData);
  }
  Future<void> _getData(ProductEvent event, Emitter<ProductsStates> emit)async{
    emit(ProductsLoadingState());
    final response = await DioHelper().getData("products");
    if(response.isSuccess){

      final model = ProductsData.fromJson(response.response!.data);

      emit(ProductsSuccessState(list: model.list));

    }else{
      emit(ProductsFailedState(message: response.message));
    }
  }

}