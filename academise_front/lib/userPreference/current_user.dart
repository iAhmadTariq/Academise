import 'package:academise_front/models/user.dart';
import 'package:academise_front/userPreference/user_preference.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController{
  final Rx<User> _currentUser = User( uid: '', firstName: '', lastName: '', dob: '', email: '',type: '').obs;
  User get user {
    getUserInfo();
    return _currentUser.value;
  } 

  getUserInfo() async{
    User? getUserInfoFromLocalStorage = await RememberUserPreference.getRememberUser();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}