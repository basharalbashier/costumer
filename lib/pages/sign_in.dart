import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';


import 'home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool la = false;
  bool doneFilling = false;
  bool val = true;
  bool _onEditing = false;
  String _code = '';

  errono(a, e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.pink.withOpacity(0.0),
        content: Container(
          // color: Colors.green,
          height: 50,
          width: 150,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.pink,
                ),
                Container(
                  width: 20,
                  height: 12,
                ),
                Text(
                  !la ? a : e,
                  style: const TextStyle(fontFamily: 'Cairo'),
                )
              ],
            ),
          ),
        )));
  }

  var name = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: doneFilling,
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: VerificationCode(
              fullBorder: true,
              textStyle: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
              keyboardType: TextInputType.number,
              underlineColor: Colors
                  .green, // If this is null it will use primaryColor: Colors.red from Theme
              length: 4,
              cursorColor: Colors
                  .blueGrey, // If this is null it will default to the ambient
              // clearAll is NOT required, you can delete it
              // takes any widget, so you can implement your design
              clearAll: const Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(Icons.cancel)),
              onCompleted: (String value) {
                print(value);
                setState(() {
                  _code = value;
                });
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: Visibility(
            visible: !doneFilling,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: name,
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person),
                    ),
                    placeholder: 'Your name please !',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: phone,
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 10,
                          ),
                          Text('+966')
                        ],
                      ),
                    ),
                    placeholder: 'Your phone number please !',
                  ),
                ),
                Text(
                  'We will send you a a text message with verification code ',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getActionButtons(),
        ),
      ],
    ));
  }

  Widget _getActionButtons() {
    return Padding(
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
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: ()
                    //  {
                    //   setState(() {
                    //     doneFilling = !doneFilling;
                    //   });
                    // }

                    async {
                  if (name.text.isEmpty) {
                    errono('Enter a name please !', 'أدخل الإسم رجاء');
                  } else if (phone.text.length < 9) {
                    errono('Enter a valid phone number please !',
                        "أدخل رقم هاتف شخص مقرب رجاء");
                  } else {
                    if (doneFilling) {
                      //////////////Get
                      
                    } else {
                      setState(() {
                        doneFilling = !doneFilling;
                      });
                    }
                    // buy();
                  }
                }

                //   // });
                // },

                ,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(la == false ? "Confirm" : "تأكيد"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
