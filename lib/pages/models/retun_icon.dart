import 'package:flutter/material.dart';

import '../../controllers/Vehicle_tybe_controller.dart';

Widget statusIcon(String status, la) {


  switch (status) {
    case '7':
      return Row(
        children: [
          Text(la
              ? "الحالة: السائق في الطريق"
              : 'Status : Driver is on the way'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '8':
      return Row(
        children: [
          Text(la?"الحالة: وصل السائق إلى نقطة الالتقاء":'Status : Driver has arrived at pick-up point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '9':
      return Row(
        children: [
          Text(la?"الحالة: السائق في طريقه إلى نقطة الإنزال":'Status : Driver is on the way to the drop point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '10':
      return Row(
        children: [
          Text(la?"الحالة: وصل السائق إلى نقطة الإنزال":'Status : Driver has arrived  the drop point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '11':
      return Row(
        children: [
          Text(la?"شكرًا على ثقتك ، هل تمانع في تقييم السائق؟":'Thank you for trust, Would you mind to rate the driver?'),
        ],
      );
  }
  return Row(
    children: [
      Text(la?"الحالة: البحث عن مركبة":'Status : Searching for a vehicle'),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.pink.shade200,
          strokeWidth: .5,
        ),
      ),
    ],
  );
}
