import 'package:ecommerce_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setInt("userId", user.userId);
    // prefs.setString("name", user.username);
    // because in login not value username we need get username in backend in future
    prefs.setString("email", user.email);
    prefs.setString("password", user.password);
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // int userId = prefs.getInt("userId");
    // String username = prefs.getString("name");
    String email = prefs.getString("email");
    String password = prefs.getString("password");

    return User(
      // userId: userId,
      // username: username,
      email: email,
      password: password,
    );
  }

  static void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.remove("userId");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("password");
  }
}
