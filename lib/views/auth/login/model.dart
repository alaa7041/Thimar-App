class UserData {
  late final UserModel model;

  UserData.fromJson(Map<String, dynamic> json) {
    model = UserModel.fromJson(json['data']);
  }
}

class UserModel {
  late final int id;
  late final String fullname;
  late final String phone;
  late final String email;
  late final String image;
  late final int isBan;
  late final bool isActive;
  late final int unreadNotifications;
  late final String userType;
  late final String token;
  late final Country country;
  late final Null city;
  late final Null identityNumber;
  late final int userCartCount;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isBan = json['is_ban'];
    isActive = json['is_active'];
    unreadNotifications = json['unread_notifications'];
    userType = json['user_type'];
    token = json['token'];
    country = Country.fromJson(json['country']);
    city = null;
    identityNumber = null;
    userCartCount = json['user_cart_count'];
  }
}

class Country {
  late final String id;
  late final String name;


  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }
}
