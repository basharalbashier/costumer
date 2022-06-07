import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../helpers/get_info.dart';
import '../helpers/gradiant_text.dart';

class CheckPoint extends StatefulWidget {
  const CheckPoint({Key? key}) : super(key: key);

  @override
  State<CheckPoint> createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  bool? signed;

  @override
  void initState() {
    getInfo(context).then((si) => Future.delayed(const Duration(seconds: 1))
        .then((value) => mounted ? setState(() => signed = si) : null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    if (signed == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pink.shade700,

            Colors.purple.shade900,

            //  Colors.blueGrey.shade900,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset('lib/assets/white.png'),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed: () {
                                    context
                                        .read<VehicleTypeController>()
                                        .setLa(true);
                                    Get.to(()=>const SignUp());
                                  },
                                  child: GradientText(
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                    "العربية",
                                    gradient: LinearGradient(colors: [
                                      Colors.pink.shade700,
                                      Colors.purple.shade900,
                                    ]),
                                  )))),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed: () {
                                    context
                                        .read<VehicleTypeController>()
                                        .setLa(false);
                                    Get.to(()=>const SignUp());
                                  },
                                  child: GradientText(
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                    "English",
                                    gradient: LinearGradient(colors: [
                                      Colors.pink.shade700,
                                      Colors.purple.shade900,
                                    ]),
                                  )))),
                    ]))
          ],
        ),
      ),
    );
  }
}
