import 'package:costumer/helpers/create_me.dart';
import 'package:costumer/helpers/replace_numbers.dart';
import 'package:costumer/pages/check_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/error_snack.dart';
import '../helpers/gradiant_text.dart';

import 'models/db.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  child: Stack(
                    children: [
                      Image.asset('lib/assets/white.png'),
                      Positioned(
                        bottom: 0,
                        left: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          context.watch<VehicleTypeController>().la
                              ? 'سعاة '
                              : 'Suat',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: name,
                    textAlign: context.watch<VehicleTypeController>().la
                        ? TextAlign.end
                        : TextAlign.start,
                    decoration: InputDecoration(
                      label: Row(
                        mainAxisAlignment:
                            context.watch<VehicleTypeController>().la
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          Text(
                            context.watch<VehicleTypeController>().la
                                ? 'الإسم '
                                : 'Name',
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                      // labelText:
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
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
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    //  textAlign:context.watch<VehicleTypeController>().la? TextAlign.end:TextAlign.start,
                    decoration: InputDecoration(
                      label: Row(
                        mainAxisAlignment:
                            context.watch<VehicleTypeController>().la
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          Text(
                            context.watch<VehicleTypeController>().la
                                ? 'رقم الهاتف'
                                : 'Mobile Number',
                          ),
                        ],
                      ),
                      prefix: const Text(
                        '+966  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      labelStyle: const TextStyle(color: Colors.white),

                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    //  textAlign:context.watch<VehicleTypeController>().la? TextAlign.end:TextAlign.start,
                    decoration: InputDecoration(
                      label: Row(
                        mainAxisAlignment:
                            context.watch<VehicleTypeController>().la
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          Text(
                            context.watch<VehicleTypeController>().la
                                ? 'الإيميل '
                                : 'Email',
                          ),
                        ],
                      ),
                      labelStyle: TextStyle(color: Colors.white),

                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //  alignLabelWithHint:true ,
                      //  hintText:context.watch<VehicleTypeController>().la?'رقم الهاتف': 'Mobile Number',
                    ),
                  ),
                ),
              ),
              _getActionButtons()
            ],
          ),
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
                // textColor: Colors.white,
                color: Colors.white,
                onPressed: () async {
                  if (phone.text.length < 9 || name.text.isEmpty) {
                    errono('Enter a valid phone number please !',
                        "أدخل رقم هاتف  صالح رجاء", context);
                  } else {
                    setState(() {
                      val = !val;
                    });
                    createMe(context, [
                      name.text,
                      replaceArabicNumber(phone.text),
                      email.text
                    ]).then((value) {
                      if (value != false) {
                        DBProvider.db.addMe([
                          value['super']['name'],
                          replaceArabicNumber(phone.text),
                          value['super']['email'],
                          value['token']
                        ]);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckPoint()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        errono('حدث خطأ ما', "Oops! try again please", context);
                      }
                    });

                    // Get.to( AddDriver(9898989898));
                    // buy();
                  }

                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: GradientText(
                  context.watch<VehicleTypeController>().la == false
                      ? "Confirm"
                      : "تأكيد",
                  gradient: LinearGradient(colors: [
                    Colors.pink.shade700,
                    Colors.purple.shade900,
                  ]),
                  // style: TextStyle(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
