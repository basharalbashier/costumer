import 'package:costumer/helpers/create_me.dart';
import 'package:costumer/helpers/replace_numbers.dart';
import 'package:costumer/pages/check_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/error_snack.dart';
import '../helpers/gradiant_text.dart';

import 'models/db.dart';

class SignUp extends StatefulWidget {
  final String phone;
  const SignUp(this.phone, {Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool account = false;
  var name = TextEditingController();
  var email = TextEditingController();

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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:38.0),
                child: Text( context.watch<VehicleTypeController>().la?'أهلا بك في سعاة':'Welcome to Souat'),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 16,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
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
                  height: MediaQuery.of(context).size.height / 16,
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
                            const BorderRadius.all(Radius.circular(5)),
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
              _getActionButtons(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )
            ],
          ),
          Positioned(
            top: 30,
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Image.asset('lib/assets/colored.png')),
                Text(
                  context.watch<VehicleTypeController>().la
                      ? 'شئ أخير'
                      : 'Last thing',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getActionButtons() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height / 16,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: RaisedButton(
              // textColor: Colors.white,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                if (email.text.isEmpty|| name.text.isEmpty) {
                  errono('Complete the fields please',
                      "اكمل الحقول رجاء", context);
                } else {
                  setState(() {
                    val = !val;
                  });
                  createMe(
                          context,
                          [
                            name.text,
                            widget.phone,
                            email.text
                          ],
                          account)
                      .then((value) {
                    if (value == 202) {
                      if (kDebugMode) {
                        print('old app');
                      }
                    }
                    if (value['super']['phone'] ==
                            widget.phone &&
                        value != 202) {
                      DBProvider.db.addMe({
                        'id': value['super']['id'],
                        'name': value['super']['name'],
                        'phone': widget.phone,
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
                    }
                    if (value == false) {
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
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
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
        ],
      ),
    );
  }
}
