import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> title = [];
  List<String> body = [];
  SharedPreferences _sp;
  void getMessage() async {
    _sp = await SharedPreferences.getInstance();
    title = _sp.getStringList('title') ?? [];
    body = _sp.getStringList('body') ?? [];
    notifyListeners();
  }

  void setNotification(String t, String b) async {
    _sp = await SharedPreferences.getInstance();

    List<String> title = _sp.getStringList('title') ?? [];
    List<String> body = _sp.getStringList('body') ?? [];
    title.add(t);
    body.add(b);
    _sp.setStringList('title', title);
    _sp.setStringList('body', body);
    notifyListeners();
  }

  void deleteNot(String t, String b) async {
    title.remove(t);
    body.remove(b);
    _sp.setStringList('title', title);
    _sp.setStringList('body', body);
    notifyListeners();
  }
}
