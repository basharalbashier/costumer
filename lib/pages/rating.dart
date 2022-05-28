import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/gradiant_text.dart';
import '../main.dart';
import 'check_page.dart';

class RateProvider extends StatefulWidget {
    var id;
   RateProvider(this.id,{Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RateProvider> {
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;
  var commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heading(context.watch<VehicleTypeController>().la
                ? 'قييم الخدمة'
                : 'Rate the service'),
            _ratingBar(_ratingBarMode),
            SizedBox(height: 20.0),
            Text(
              '${context.watch<VehicleTypeController>().la ? 'التقييم  ' : 'Rating'}: $_rating',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  labelText: context.watch<VehicleTypeController>().la
                      ? 'تعليق '
                      : 'Comment',
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
            _getActionButtons()
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    return RatingBar.builder(
      initialRating: _initialRating,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }

  Widget _heading(String text) => Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      );

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
               
                color: Colors.white70,
                onPressed: () async {
                  if (1 == 1) {
                    try {
                      var response = await http.put(
                          Uri.parse('${url}api/orders/${widget.id}'),
                          headers: header,
                          body: {
                            'rate': _rating.toString(),
                            'user_comment': commentController.text
                          });
                      // print(response.body);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CheckPoint()),
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {}
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckPoint()),
                      (Route<dynamic> route) => false,
                    );
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
