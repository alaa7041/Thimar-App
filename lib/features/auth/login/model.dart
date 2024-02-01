
part of 'bloc.dart';
class UserData {
  late final UserModel model;

  UserData.fromJson(Map<String, dynamic> json) {
    model = UserModel.fromJson(json['data']);
  }
}

class UserModel {
  late final int id;
  late final String fullName, phone, email, image,userType,token;
  late final num isBan, unreadNotifications,userCartCount;
  late final bool isActive;
  late final Country? country;
  late final void city;
  late final void identityNumber;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    fullName = json['fullname']??'';
    phone = json['phone']??'';
    email = json['email']??'';
    image = json['image']??'';
    isBan = json['is_ban']??0;
    isActive = json['is_active'];
    unreadNotifications = json['unread_notifications'];
    userType = json['user_type']??'';
    token = json['token']??'';
    country = json['country']!=null?Country.fromJson(json['country']):null;
    city = null;
    identityNumber = null;
    userCartCount = json['user_cart_count']??0;
  }
}

class Country {
  late final String id,name;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    name = json['name']??'';
  }
}
