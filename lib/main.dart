import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/helpers/get_my_orders.dart';
import 'package:costumer/pages/check_page.dart';
import 'package:costumer/pages/google_map.dart';
import 'package:costumer/pages/models/db.dart';
import 'package:costumer/pages/orderScreen.dart';
import 'package:costumer/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'helpers/error_snack.dart';
import 'helpers/gradiant_text.dart';
import 'pages/home.dart';

String url = 'https://bashardinho.loca.lt/';
var header = {
  'Accept': 'application/json',
};
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => VehicleTypeController(),
      )
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blueGrey,
      ),
      home: CheckPoint(),
    ),
  ));
}
