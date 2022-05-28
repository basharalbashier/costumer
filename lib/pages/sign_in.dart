
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
                    labelStyle: TextStyle(color: Colors.white),
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
              padding: const EdgeInsets.only(left: 10.0, right: 20),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: Text('+966',
                    style: TextStyle(color: Colors.white),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: TextField(
                        keyboardType: TextInputType.phone,
                      controller: phone,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
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
           

           Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
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
                color: Colors.white,
                onPressed: () async {
                  if (phone.text.length < 9 || name.text.isEmpty) {
                    errono('Enter a valid phone number please !',
                        "أدخل رقم هاتف  صالح رجاء", context);
                  } else {
                    setState(() {
                      val = !val;
                    });
                    DBProvider.db.addMe([name.text, replaceArabicNumber(phone.text), email.text]);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckPoint()),
                      (Route<dynamic> route) => false,
                    );
                    // Get.to( AddDriver(9898989898));
                    // buy();
                  }

                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: GradientText(context.watch<VehicleTypeController>().la == false
                    ? "Confirm"
                    : "تأكيد",
                      gradient: LinearGradient(colors: [
                                      Colors.pink.shade700,
                                      Colors.purple.shade900,
                                    ]),
                                    // style: TextStyle(fontSize: 30),
                    
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
