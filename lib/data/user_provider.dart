import 'package:ecommerce_app/data/user_preferences.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  getUser() async {
    _user = await UserPreferences.getUser();
    notifyListeners();
  }

  delUser() {
    _user = null;
    notifyListeners();
  }
}
