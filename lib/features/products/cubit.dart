import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';
import 'model.dart';
import 'states.dart';



class ProductCubit extends Cubit<ProductsStates>{
  ProductCubit():super(ProductsStates());

  Future<void> getData()async{
    emit(ProductsLoadingState());
    final response = await DioHelper().getData("products");
    if(response.isSuccess){
      final model = ProductsData.fromJson(response.response!.data);
      emit(ProductsSuccessState(list: model.list));
    }else{
      emit(ProductsFailedState(msg: response.message));
    }
  }

}