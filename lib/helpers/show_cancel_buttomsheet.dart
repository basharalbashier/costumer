// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:costumer/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/check_page.dart';

void showCancelBottomSheet(context, id, la) {
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
            cancelTheTrip(context, id, 1);
          },
          child: Text(la
              ? "استغرقت وقتًا طويلاً للحصول على سائق"
              : 'Took too long to get driver'),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 2);
          },
          child: Text(la ? "بسبب السعر" : 'Because of the price'),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 3);
            // Navigator.pop(context);
          },
          child: Text(la ? "بسبب موقف السائق" : 'Because of driver attitude'),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            cancelTheTrip(context, id, 4);
          },
          child: Text(la ? "سبب آخر" : 'Other'),
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

cancelTheTrip(context, id, i) async {
  var date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  DateTime now = DateTime.now();
  String formattedTime = DateFormat.Hm().format(now);
  try {
    var response = await http.put(Uri.parse('${url}api/orders/$id'),
        headers: header,
        body: {
          'status': i.toString(),
          'canceled_at': '$date   $formattedTime'
        });
    print(response.body);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CheckPoint()),
      (Route<dynamic> route) => false,
    );
  } catch (e) {}
}
