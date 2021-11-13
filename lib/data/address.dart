import 'dart:convert';

import 'package:ecommerce_app/model/Address.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:http/http.dart' as http;

class AddressConnect {
  Address address;

  Future<Address> getAddress() async {
    http.Response response = await http.get(Uri.parse(AppUrl.address));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      address = Address.fromJson(body);
      return address;
    } else {
      print('error');
    }
  }
}
