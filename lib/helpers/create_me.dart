import 'dart:convert';
import 'package:costumer/helpers/replace_numbers.dart';
import 'package:costumer/pages/models/insert_user_to_db.dart';
import 'package:costumer/pages/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/check_page.dart';
import 'constants.dart';
import 'error_snack.dart';

Future<int> checkMe(context, String phone, bool accounType) async {
  http.Response respons;

  try {
    respons = await http
        .post(Uri.parse('${url}api/superuser/check'), headers: header, body: {
      'phone': phone,
    });

    if (respons.statusCode == 201) {
    await doTheInsert(jsonDecode(respons.body), phone);
   
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CheckPoint()),
          (Route<dynamic> route) => false,
        );
          return respons.statusCode ;
  }else if(respons.statusCode == 205){
     

       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  SignUp(phone)),
          (Route<dynamic> route) => false,
        );

    return respons.statusCode ;
    
    }else{
 errono('حدث خطأ في مشغلاتنا، نعتذر حاول مجدداً', "Oops! try again please",
        context);

    return 0;
    }
   
  } catch (e) {
   
    errono('حدث خطأ ما', "Oops! try again please", context);

    return 0;
  }
}

Future<dynamic> createMe(context, List<String> info, bool accounType) async {
  http.Response respons;

  try {
    respons = await http
        .post(Uri.parse('${url}api/superuser/add'), headers: header, body: {
      'name': info[0],
      'phone': info[1],
      'email': info[2],
      'account': accounType ? '1' : '0',
      'vers': '102'
    });
    if (respons.statusCode == 202) {
      return respons.statusCode;
    }
    if (respons.statusCode == 200 || respons.statusCode == 201) {
      return jsonDecode(respons.body);
    }
    errono('حدث خطأ في مشغلاتنا، نعتذر حاول مجدداً', "Oops! try again please",
        context);

    return false;
  } catch (e) {
    errono('حدث خطأ ما', "Oops! try again please", context);

    return false;
  }
}
