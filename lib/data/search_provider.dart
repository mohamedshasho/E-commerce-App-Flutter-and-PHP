import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _searched = [];
  SharedPreferences _sp;
  List<String> get searched => _searched;
  Future setSearched(String item) async {
    _sp = await SharedPreferences.getInstance();
    String f =
        _searched.firstWhere((element) => element == item, orElse: () => null);
    if (f == null) {
      _searched.insert(_searched.length, item);
      await _sp.setStringList('search', _searched);
      notifyListeners();
    } else {}
  }

  void fetchData() async {
    _sp = await SharedPreferences.getInstance();
    _searched = _sp.getStringList('search') ?? [];
    notifyListeners();
  }

  Future deleteSearched(String item) async {
    _sp = await SharedPreferences.getInstance();
    _searched.remove(item);
    await _sp.setStringList('search', _searched);
    notifyListeners();
  }
}
