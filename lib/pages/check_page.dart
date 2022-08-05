import 'dart:ui';

import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/pages/sign_in.dart';
import 'package:costumer/pages/varify_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../helpers/get_info.dart';
import '../helpers/gradiant_text.dart';
import 'models/swep_languages.dart';

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
    if (signed == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // top: -30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                ),
              ),
            ),
          ),
          languageWidget(context, Colors.white),
          // Center(
          //     // padding: EdgeInsets.only(
          //     //     left: 10.0,
          //     //     right:10.0,
          //     //     top: MediaQuery.of(context).size.height / 1.1),
          //     child:
          //     Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           Expanded(
          //               flex: 2,
          //               child: Padding(
          //                   padding: const EdgeInsets.only(left: 10.0),
          //                   child: RaisedButton(
          //                       shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(10.0)),
          //                       textColor: Colors.white,
          //                       color: Colors.white,
          //                       onPressed: () {
          //                         Get.to(() => const Varify());
          //                       },
          //                       child: SizedBox(
          //                         height: 50,
          //                         child: Center(
          //                           child: GradientText(
          //                             style: const TextStyle(
          //                               fontSize: 20,
          //                               fontWeight: FontWeight.w900
          //                             ),
          //                             context.watch<VehicleTypeController>().la
          //                                 ? "لنبدأ"
          //                                 : "Let's Start",
          //                             gradient: LinearGradient(colors: [
          //                               Colors.purple.shade900,
          //                               Colors.purple.shade900,
          //                             ]),
          //                           ),
          //                         ),
          //                       )))),
          //         ])),

          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 4,
                  left: MediaQuery.of(context).size.width / 4,
                  top: MediaQuery.of(context).size.height / 2),
              child: Column(
                children: [
                  Text(
                    Provider.of<VehicleTypeController>(context).la
                        ? "قم بتحميل ، ونقل أي شيء تقريبًا ، وقتما تشاء"
                        : "Load, haul deliver just about anything, whenever you need it",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                                      Get.to(() => const Varify());
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: GradientText(
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                context
                                                        .watch<
                                                            VehicleTypeController>()
                                                        .la
                                                    ? "لنبدأ"
                                                    : "Let's Start",
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.purple.shade900,
                                                  Colors.purple.shade900,
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child:   Icon(Icons.arrow_forward,color: Theme.of(context)
                                                .colorScheme
                                                .secondary,)
                                          
                                          
                                        
                                        ),
                                      ],
                                    )))),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
