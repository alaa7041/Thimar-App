import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/logic/dio_helper.dart';
import 'package:thimar/features/home/pages/cart/update/states.dart';
import '../../../../core/logic/cache_helper.dart';
import 'delet/events.dart';
import 'delet/states.dart';
import 'events.dart';
import 'model.dart';
import 'states.dart';
import 'store/events.dart';
import 'store/states.dart';
import 'update/events.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc() : super(CartStates()) {
    on<CartEvent>(_showCart);
    on<DeleteItemFromCartEvent>(_deleteItem);
    on<UpdateItemInCartEvent>(_upDataItem);
    on<StoreItemInCartEvent>(_storeItem);
  }

  int count = CacheHelper.getCount();
  int totalProduct = 180;
  int discount = 40;

  Future<void> _showCart(CartEvent event, Emitter<CartStates> emit) async {
    emit(CartLoadingState());

    final response = await DioHelper().getData("client/cart");

    if (response.isSuccess) {
      final model = CartData.fromJson(response.response!.data);
      emit(CartSuccessState(list: model.list, message: "Success"));
    } else {
      emit(CartFieldState(message: response.message.toString()));
    }
  }

  Future<void> _deleteItem(DeleteItemFromCartEvent event, Emitter<CartStates> emit) async {
    emit(DeleteItemFromCartLoadingState());
    final response = await DioHelper().sendData(
        "client/cart/delete_item/${event.id}",
        data: {"_method": "DELETE"});

    if (response.isSuccess) {
      emit(DeleteItemFromCartSuccessState());
    } else {
      emit(DeleteItemFromCartFailedState());
    }
  }

  Future<void> _upDataItem(UpdateItemInCartEvent event, Emitter<CartStates> emit) async {
    final response = await DioHelper()
        .sendData("client/cart/${event.id}", data: {"_method": "PUT"});

    if (response.isSuccess) {
      emit(UpdateItemInCartSuccessState());
    } else {
      emit(UpdateItemInCartFieldState());
    }
  }

  Future<void> _storeItem(StoreItemInCartEvent event, Emitter<CartStates> emit) async {

    emit(StoreItemInCartLoadingState(productId: event.productId));

    final response = await DioHelper().sendData("client/cart");

    if (response.isSuccess) {
      final model =  SortItemInCartData.fromJson(response.response!.data);

      emit(StoreItemInCartSuccessState(list: model.list));
      addItem(){
        model.list.insertAll(model.list.length, model.list);
      }

    } else {
      emit(StoreItemInCartFieldState(message: response.message.toString()));
    }
  }
}
