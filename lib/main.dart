import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/helpers/get_my_orders.dart';
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

import 'pages/home.dart';

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

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

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
        primarySwatch: Colors.blueGrey,
      ),
      home: CheckPoint(),
    ),
  ));
}

class CheckPoint extends StatefulWidget {
  const CheckPoint({Key? key}) : super(key: key);

  @override
  State<CheckPoint> createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  bool? signed;

  getInfo() {
    DBProvider.db.getMe().then(((info) async {
      if (info != 0) {
     
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home(info[0])),
            (Route<dynamic> route) => false,
          );
        }
    
    

       else {
        setState(() {
          signed = true;
        });
      }
    }));
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (signed == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    FlutterNativeSplash.remove();

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
              child: Image.asset('lib/assets/new.png'),
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
                                    Get.to(SignUp());
                                  },
                                  child: GradientText(
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
                                    Get.to(SignUp());
                                  },
                                  child: GradientText(
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

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: Image.asset('lib/assets/new.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: context.watch<VehicleTypeController>().la
                        ? 'الإسم '
                        : 'Name',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    //  alignLabelWithHint:true ,
                    //  hintText:context.watch<VehicleTypeController>().la?'رقم الهاتف': 'Mobile Number',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: context.watch<VehicleTypeController>().la
                        ? 'الإيميل '
                        : 'Email',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    //  alignLabelWithHint:true ,
                    //  hintText:context.watch<VehicleTypeController>().la?'رقم الهاتف': 'Mobile Number',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: Text('+966')),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                        labelText: context.watch<VehicleTypeController>().la
                            ? 'رقم الهاتف'
                            : 'Mobile Number',
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        //  alignLabelWithHint:true ,
                        //  hintText:context.watch<VehicleTypeController>().la?'رقم الهاتف': 'Mobile Number',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _getActionButtons()
          ],
        ),
      ),
    );
  }

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  bool val = true;
  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.indigo,
                onPressed: () async {
                  if (phone.text.length < 9 || name.text.isEmpty) {
                    errono('Enter a valid phone number please !',
                        "أدخل رقم هاتف  صالح رجاء", context);
                  } else {
                    setState(() {
                      val = !val;
                    });
                    DBProvider.db.addMe([name.text, phone.text, email.text]);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CheckPoint()),
                      (Route<dynamic> route) => false,
                    );
                    // Get.to( AddDriver(9898989898));
                    // buy();
                  }

                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(context.watch<VehicleTypeController>().la == false
                    ? "Confirm"
                    : "تأكيد"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
