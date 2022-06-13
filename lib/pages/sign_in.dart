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
  bool account = false;
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  bool val = true;
  @override
  Widget build(BuildContext context) {
    if (!val) {
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
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Colors.pink.shade700,

        //     Colors.purple.shade900,

        //     //  Colors.blueGrey.shade900,
        //   ],
        // )),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 1.0),
                  child: SizedBox(
                    child: Stack(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Image.asset('lib/assets/colored.png')),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            context.watch<VehicleTypeController>().la
                                ? 'سعاة '
                                : 'Suat',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize:
                                    MediaQuery.of(context).size.width / 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                        // labelStyle: const TextStyle(color: Colors.white),
                        // labelText:
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(100)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0),
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
                          // style: TextStyle(color: Colors.white),
                        ),
                        // labelStyle: const TextStyle(color: Colors.white),

                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(100)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0),
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
                                  : 'E-mail',
                            ),
                          ],
                        ),

                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0),
                        ),
                        //  alignLabelWithHint:true ,
                        //  hintText:context.watch<VehicleTypeController>().la?'رقم الهاتف': 'Mobile Number',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: context.watch<VehicleTypeController>().la
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        context.watch<VehicleTypeController>().la
                            ? 'حساب أعمال '
                            : 'E-mail',
                      ),
                      Checkbox(
                          value: account,
                          onChanged: (acc) {
                            setState(() {
                              account = acc!;
                            });
                          }),
                    ],
                  ),
                ),
                _getActionButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: MediaQuery.of(context).size.height / 20,
          bottom: 8),
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
                color: Theme.of(context).colorScheme.primary,
                onPressed: () async {
                  if (phone.text.length < 9 || name.text.isEmpty) {
                    errono('Enter a valid phone number please !',
                        "أدخل رقم هاتف  صالح رجاء", context);
                  } else {
                    setState(() {
                      val = !val;
                    });
                    createMe(
                            context,
                            [
                              name.text,
                              replaceArabicNumber(phone.text),
                              email.text
                            ],
                            account)
                        .then((value) {
                          print(value);
                      if (value != false) {
                        DBProvider.db.addMe({
                          'id': value['super']['id'],
                          'name': value['super']['name'],
                          'phone': replaceArabicNumber(phone.text),
                          'email': value['super']['email'],
                          'account': value['super']['account'],
                          'token': value['token']
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckPoint()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          val = !val;
                        });
                      }
                    });

                    // Get.to( AddDriver(9898989898));
                    // buy();
                  }

                  // });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: GradientText(
                    context.watch<VehicleTypeController>().la == false
                        ? "Confirm"
                        : "تأكيد",
                    gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white]),
                    // style: TextStyle(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
