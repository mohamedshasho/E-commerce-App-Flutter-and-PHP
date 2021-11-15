import 'package:flutter/foundation.dart';

class BottomBarProvider extends ChangeNotifier {
  int _page = 0;
  int get page => _page;
  void getPage(int index) {
    _page = index;
    notifyListeners();
  }
}
