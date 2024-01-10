part of'bloc.dart';

class GetCitiesStates{}

class GetCitiesLoadingState extends GetCitiesStates{}
class GetCitiesSuccessState extends GetCitiesStates{
  final String message;
  final List<CitiesModel> list;

  GetCitiesSuccessState({required this.message,required this.list}){
    showMessage(message,type: MessageType.success);
  }
}
class GetCitiesFailedState extends GetCitiesStates{}
