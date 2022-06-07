import 'package:costumer/helpers/gradiant_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';

Widget drawer(context, info) {
  return Drawer(
    width: MediaQuery.of(context).size.width / 3,
    child: Column(
      
      children: [

        Container(
          // color: Colors.blueGrey,

          height:  MediaQuery.of(context).size.height / 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
          info['name'],
          gradient: LinearGradient(colors: [
            Colors.pink.shade700,
            Colors.purple.shade900,
          ]),
        ),
        GradientText(
          info['email'],
          gradient: LinearGradient(colors: [
            Colors.pink.shade700,
            Colors.purple.shade900,
          ]),
        ),

          ],),
        ),
      
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Provider.of<VehicleTypeController>(context, listen: true).la
                    ? "الطلبات السابقة":'History'),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Provider.of<VehicleTypeController>(context, listen: true).la
                    ? " تواصل معنا":'Contact us'),
          ),

      ],
    ),
  );
}
