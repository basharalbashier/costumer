import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

Future<dynamic> createMe(context,List<String> info) async {
  http.Response respons;

  try {
    respons =
        await http.post(Uri.parse('${url}api/superuser/add'), headers: header, body: {
      'name': info[0],
      'phone': info[1],
      'email': info[2],
    });
    if (respons.statusCode == 200 || respons.statusCode == 201) {

      
     return jsonDecode(respons.body);
  
    }
      
   return false;
    
  
  } catch (e) {
    return false;
  }
}
