import 'dart:convert';

import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/categories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderCategories extends ChangeNotifier {
  List<Categories> _categories = [];
  List<Categories> get categories {
    return _categories;
  }

  Future<void> fetchAllData() async {
    try {
      var response = await http.get(Uri.parse(AppUrl.categories));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        for (var p in body) {
          Categories categories = Categories.fromJson(p);
          Categories isExist = _categories
              .firstWhere((val) => val.id == categories.id, orElse: () => null);

          if (isExist == null) {
            _categories.add(categories);
          }
        }
        return _categories;
      } else {
        print('no data provider');
      }
    } catch (e) {
      throw 'No internet Access';
    }
  }
}
