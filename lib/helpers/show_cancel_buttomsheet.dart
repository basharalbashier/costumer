// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
import 'dart:convert';

import 'package:costumer/helpers/error_snack.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../pages/check_page.dart';
import 'constants.dart';

void showCancelBottomSheet(context, id, la, info) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(la ? 'عذراً' : 'Sorry!'),
      message: Text(la
          ? "لأننا نهتم ، نود معرفة سبب إلغاء الشحن؟"
          : 'Because we care, We would like to know why you cancele the shipping?'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 1, info['token']);
          },
          child: Text(la
              ? "استغرقت وقتًا طويلاً للحصول على سائق"
              : 'Took too long to get driver',style: TextStyle(color: Colors.blueGrey.shade900)),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 2,  info['token']);
          },
          child: Text(la ? "بسبب السعر" : 'Because of the price',style: TextStyle(color: Colors.blueGrey.shade900)),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 3,  info['token']);
            // Navigator.pop(context);
          },
          child: Text(la ? "بسبب موقف السائق" : 'Because of driver attitude',style: TextStyle(color: Colors.blueGrey.shade900)),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 4,  info['token']);
          },
          child: Text(la ? "سبب آخر" : 'Other',style: TextStyle(color: Colors.blueGrey.shade900),),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as delete or exit and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(la ? 'رجوع' : 'Cancel'),
        )
      ],
    ),
  );
}

cancelTheTrip(context, id, i, token) async {

  var date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  DateTime now = DateTime.now();
  String formattedTime = DateFormat.Hm().format(now);
  try {
    var response = await http.put(Uri.parse('${url}api/orders/$id'), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    }, body: {
      'status': i.toString(),
      'canceled_at': '$date   $formattedTime'
    });

    if((response.statusCode==201 || response.statusCode==200 ) && jsonDecode(response.body)['id']==id){
      Provider.of<VehicleTypeController>(context,listen: false).firstPoint.clear();
      Provider.of<VehicleTypeController>(context,listen: false).dropPoint.clear();
       Provider.of<VehicleTypeController>(context,listen: false).finalFee='0.00';

      
       Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const CheckPoint()),
      (Route<dynamic> route) => false,
    );

    }
   
  } catch (e) {
    errono("حدث خطأ في الإتصال", "A connection error occurred", context);
  }
}
