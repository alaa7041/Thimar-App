import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/products/events.dart';
import '../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';



class ProductBloc extends Bloc<ProductEvents,ProductsStates>{
  ProductBloc():super(ProductsStates());

  Future<void> getData()async{
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