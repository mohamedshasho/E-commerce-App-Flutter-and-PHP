import 'dart:convert';

import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProducts extends ChangeNotifier {
  List<Products> _products = [];
  List<Products> productsfilter = [];
  SharedPreferences _pref;
  List<String> _favorite = [];

  List<Products> get getProducts => _products;

  List<String> get favorite => _favorite;

  Products getProFav(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  void setProducts(List<Products> product) {
    _products = product;
    notifyListeners();
  }

  void delFavoriteProducts() async {
    _favorite = [];
    await _pref.setStringList('favorite', []);
  }

  Future setFavorite(String id) async {
    String f =
        _favorite.firstWhere((element) => element == id, orElse: () => null);
    if (f == null) {
      _favorite.insert(_favorite.length, id);
      await _pref.setStringList('favorite', _favorite);
    } else {
      _favorite.remove(f);
      await _pref.setStringList('favorite', _favorite);
    }
    //print(_favorite);
    notifyListeners();
  }

  bool getFavorite(String id) {
    bool found = false;
    if (_favorite == null) {
      return false;
    } else {
      _favorite.forEach(
        (element) {
          if (element == id) found = true;
        },
      );
    }
    print(_favorite);
    return found;
    // notifyListeners();
  }

  Future<void> fetchAllData() async {
    _pref = await SharedPreferences.getInstance();
    _favorite = _pref.getStringList('favorite') ?? [];
    try {
      var response = await http.get(Uri.parse(AppUrl.products));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        for (var p in body) {
          Products product = Products.fromJson(p);
          Products isExist = _products.firstWhere((val) => val.id == product.id,
              orElse: () => null);

          if (isExist == null) {
            _products.add(product);
          }
        }
        productsfilter = _products;
        notifyListeners();
        return _products;
      } else {
        print('no data provider');
        notifyListeners();
        return null;
      }
    } catch (e) {
      throw 'no internet access';
    }
  }

  Future fetchFilter(int price, String category) async {
    // '0' is All item
    if (category != '0') {
      productsfilter = _products
          .where((val) =>
              (int.parse(val.price) <= price && category == val.categoryId))
          .toList();
    } else {
      productsfilter =
          _products.where((val) => (int.parse(val.price) <= price)).toList();
    }
    notifyListeners();
  }

  Future<List<Products>> searchItems(String item) async {
    List<Products> items;

    if (item != null) {
      items =
          _products.where((element) => element.name.contains(item)).toList();
    }
    return items;
  }
}
