import 'model.dart';

class GetCitiesStates{}

class GetCitiesLoadingState extends GetCitiesStates{}
class GetCitiesSuccessState extends GetCitiesStates{

  final List<CitiesModel> list;

  GetCitiesSuccessState({required this.list});
}
class GetCitiesFailedState extends GetCitiesStates{}
