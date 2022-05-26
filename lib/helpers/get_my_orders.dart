import 'dart:convert';

import 'package:costumer/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/orderScreen.dart';

Future<List> getMyOreders(phone, context) async {
  List list = [];
 
  try {
    var response = await http
        .post(Uri.parse('${url}api/orders/my_orders/$phone'), headers: header);
 print(json.decode(response.body));
    for (var i in json.decode(response.body)) {
      if (i['status'] == '0' ||
          i['status'] == '7' ||
          i['status'] == '8' ||
          i['status'] == '9' ||
          i['status'] == '10') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen(i)),
          (Route<dynamic> route) => false,
        );
        break;
      }
      list.add(i);
    }
  } catch (e) {}

  return list;
}
