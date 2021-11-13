import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactProvider extends ChangeNotifier {
  Contact _contact;

  get contact {
    return _contact;
  }

  Future<dynamic> sendMsg(Contact contact) async {
    _contact = contact;

    var data;
    var result;
    if (contact.username != null) {
      var send = json.decode(
          json.encode({"username": contact.username, "msg": contact.msg}));
      var response = await http.post(
        Uri.parse(AppUrl.contact),
        body: send,
      );
      data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data == "Successfully") {
          result = {
            'status': true,
            'message': 'send Successfully',
            'data': data
          };
        } else {
          result = {'status': false, 'message': 'send failed', 'data': data};
        }
        return result;
      }
    } else
      return null;
  }
}
