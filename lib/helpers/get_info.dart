import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/models/db.dart';

Future<bool> getInfo(context) async {
  var info = await DBProvider.db.getMe();
  
  bool signed = false;
  if (info != 0) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home(info[0])),
      (Route<dynamic> route) => false,
    );
  } else {
    signed = true;
  }
  return signed;
}
