part of 'bloc.dart';
class GetCities {

  late final List<CitiesModel> list;
  late final String status;
  late final String message;

  GetCities.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']).map((e)=>CitiesModel.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }
}

class CitiesModel {

  late final String id;
  late final String name;

  CitiesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

}