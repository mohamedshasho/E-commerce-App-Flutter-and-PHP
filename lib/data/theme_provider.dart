import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  SharedPreferences _sp;
  void updateTheme(bool isDarkMode) async {
    _sp = await SharedPreferences.getInstance();
    this.isDarkMode = isDarkMode;
    _sp.setBool('theme', isDarkMode);
    notifyListeners();
  }

  void getDataTheme() async {
    // new used first and remove this commit
    _sp = await SharedPreferences.getInstance();
    isDarkMode = _sp.getBool('theme') ?? false;
    notifyListeners();
  }
}
