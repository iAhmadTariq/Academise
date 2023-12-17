import 'dart:convert';
import 'package:academise_front/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPreference {
  
  static Future<void> saveRemeberUser (User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String userJsonData = json.encode(user.toJson());
    await prefs.setString('currentUser', userJsonData);
  }

  static Future<User?> getRememberUser () async {
    User currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString('currentUser');
    if (userInfo != null) {
      Map<String, dynamic> userJsonData = json.decode(userInfo);
      currentUser = User.fromJson(userJsonData);
      return currentUser;
    }
    return null;
  }

  static Future<void> removeRememberUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }
}