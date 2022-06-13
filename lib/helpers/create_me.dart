import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'error_snack.dart';

Future<dynamic> createMe(context,List<String> info,bool accounType) async {
  http.Response respons;

  try {
    respons =
        await http.post(Uri.parse('${url}api/superuser/add'), headers: header, body: {
      'name': info[0],
      'phone': info[1],
      'email': info[2],
      'account':accounType?'1':'0',
    });
  
    if (respons.statusCode == 200 || respons.statusCode == 201) {

      
     return jsonDecode(respons.body);
  
    }
                              errono('حدث خطأ في مشغلاتنا، نعتذر حاول مجدداً', "Oops! try again please", context);

   return false;
    
  
  } catch (e) {
                            errono('حدث خطأ ما', "Oops! try again please", context);

    return false;
  }
}
