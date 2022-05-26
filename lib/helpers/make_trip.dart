




 import 'dart:convert';

import 'package:costumer/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../controllers/Vehicle_tybe_controller.dart';
import '../pages/orderScreen.dart';

makeTrip(context,info,choosenType) {
    try {
      http.post(Uri.parse('${url}api/orders'), headers: header, body: {
        'user_name': info['name'],
        'user_phone': info['phone'],
        'start_address':
            Provider.of<VehicleTypeController>(context, listen: false)
                .firstPoint[0],
        'start_late': Provider.of<VehicleTypeController>(context, listen: false)
            .firstPoint[1],
        'start_longe':
            Provider.of<VehicleTypeController>(context, listen: false)
                .firstPoint[2],
        'end_address':
            Provider.of<VehicleTypeController>(context, listen: false)
                .dropPoint[0],
        'end_late': Provider.of<VehicleTypeController>(context, listen: false)
            .dropPoint[1],
        'end_longe': Provider.of<VehicleTypeController>(context, listen: false)
            .dropPoint[2],
        'fee':
            Provider.of<VehicleTypeController>(context, listen: false).finalFee,
        'car_type': choosenType['id'].toString(),
        'distance': Provider.of<VehicleTypeController>(context, listen: false)
            .distanceData,
        'status': '0',
      }).then((value) {
        if ((value.statusCode == 200 || value.statusCode == 201) &&
            Provider.of<VehicleTypeController>(context, listen: false)
                    .firstPoint[1] ==
                jsonDecode(value.body)['start_late']) {
          if (kDebugMode) {
            print(jsonDecode(value.body)['start_late']);
          }
          Map i = jsonDecode(value.body);
                     Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen(i)),
                      (Route<dynamic> route) => false,
                    );
          // Get.to(OrderScreen(i));
        } else {
          if (kDebugMode) {
            print('noooooo');
          }
        }
        // for (var i in list) {
        //   if (kDebugMode) {
        //
        //   }
        // }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
