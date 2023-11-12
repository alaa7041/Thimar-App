 import '../../views/auth/login/model.dart';
 import 'package:shared_preferences/shared_preferences.dart';


class CasheHelper{
  static late final SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static int getCount(){
    return _prefs.getInt("countkey")??0;
  }
  static Future<bool> setCount(int value){
    return _prefs.setInt("countkey", value);
  }
  static Future<bool> clear(){
    print("cleared Success");
    return _prefs.clear();
  }
  static Future<void> saveUserData(UserModel model)async{
   await  _prefs.setString("phone",model.phone);
   await _prefs.setString("email",model.email);
   await _prefs.setString("token",model.token);
   await _prefs.setString("fullname",model.fullname);
   await _prefs.setString("image",model.image);
   await _prefs.setBool("isActive",model.isActive);
   await _prefs.setString("city_id",model.country.id);
   await _prefs.setString("city_name",model.country.name);

  }
  static bool isAuth(){
    String? token = _prefs.getString("token");
    return token!= null || (token??"").isNotEmpty;
  }

}