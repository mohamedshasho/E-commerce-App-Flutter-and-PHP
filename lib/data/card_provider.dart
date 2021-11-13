import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  // List<Products> _products = [];
  List<String> storeProducts = [];
  SharedPreferences _sp;

  Future<bool> setCard(String item) async {
    _sp = await SharedPreferences.getInstance();
    String f = storeProducts.firstWhere((element) => element == item,
        orElse: () => null);
    if (f == null) {
      storeProducts.add(item);
      await _sp.setStringList('cart', storeProducts);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void fetchData() async {
    _sp = await SharedPreferences.getInstance();
    storeProducts = _sp.getStringList('cart') ?? [];
    notifyListeners();
  }

  Future deleteCard(String item) async {
    _sp = await SharedPreferences.getInstance();
    storeProducts.remove(item);
    await _sp.setStringList('cart', storeProducts);
    notifyListeners();
  }

  void removeAllCart() async {
    _sp = await SharedPreferences.getInstance();
    storeProducts.clear();
    await _sp.setStringList('cart', storeProducts);
    notifyListeners();
  }
}
