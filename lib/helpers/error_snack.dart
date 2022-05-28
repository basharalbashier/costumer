





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';

errono(a, e, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      const Icon(
        Icons.error,
        color: Colors.pink,
      ),
      const SizedBox(
        width: 20,
        height: 12,
      ),
      Text(
        Provider.of<VehicleTypeController>(context, listen: false).la ? a : e,
        style: const TextStyle(fontFamily: 'Cairo'),
      )
    ],
  )));
}
