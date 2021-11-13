import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/data/user_preferences.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    var data;
    String token = await FirebaseMessaging.instance.getToken();
    var user = json.decode(json.encode(
        {"email": email, "password": password, "token": token.toString()}));

    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    try {
      var response = await http.post(
        Uri.parse(AppUrl.login),
        body: user,
      );
      data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data == "Successfully") {
          print(user);
          User authUser = User.fromJson(user);
          UserPreferences.saveUser(authUser);
          _loggedInStatus = Status.LoggedIn;
          notifyListeners();

          result = {'status': true, 'message': 'Successful', 'user': authUser};
        } else {
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          result = {'status': false, 'message': data};
        }
        return result;
      }
    } catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {'status': false, 'message': e};
      return result;
    }

    _loggedInStatus = Status.NotLoggedIn;
    notifyListeners();
    print(data);
    return data;
  }

  //final Map<String, dynamic> responseData = json.decode(response.body);

  //var userData = responseData['data'];  في حال يوجد معلومات اضافية نرجعها من النت ونخزنها

  Future<Map<String, dynamic>> register(
      String username, String email, String password, String token) async {
    var result;
    var data;
    var user = json.decode(
      json.encode(
        {
          "username": username,
          "email": email,
          "password": password,
          "token": token,
        },
      ),
    );
    _registeredInStatus = Status.Registering;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse(AppUrl.register),
        body: user,
      );
      data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data == "Successfully") {
          print(user);
          User authUser = User.fromJson(user);

          UserPreferences.saveUser(authUser);
          result = {
            'status': true,
            'message': 'Successfully registered',
            'data': authUser
          };
          _registeredInStatus = Status.Registered;
          notifyListeners();
        } else {
          _registeredInStatus = Status.NotRegistered;
          notifyListeners();
          result = {
            'status': false,
            'message': 'Registration failed',
            'data': data
          };
        }
        return result;
      }
    } catch (e) {
      _registeredInStatus = Status.NotRegistered;
      result = {'status': false, 'message': '${e.toString()}', 'data': data};
      print(result);
      return result;
    }
    result = {'status': false, 'message': 'Registration failed', 'data': data};
    return result;
  }
}
