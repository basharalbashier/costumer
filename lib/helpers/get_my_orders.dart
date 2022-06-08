import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/orderScreen.dart';
import 'constants.dart';

Future<List> getMyOreders(info, context) async {
  List list = [];

  try {
    var response = await http.post(
        Uri.parse('${url}api/orders/my_orders/${info['phone']}'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer ${info['token']}'
        });
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
