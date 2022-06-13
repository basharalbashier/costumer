import 'dart:convert';

import 'package:costumer/helpers/check_internet.dart';
import 'package:costumer/helpers/error_snack.dart';
import 'package:costumer/helpers/get_my_orders.dart';
import 'package:costumer/helpers/gradiant_text.dart';
import 'package:costumer/pages/models/colculating_distans.dart';
import 'package:costumer/pages/models/colculating_fee.dart';
import 'package:costumer/pages/models/db.dart';
import 'package:costumer/widgets/drawer.dart';
import 'package:costumer/widgets/poins_cards.dart';
import 'package:costumer/widgets/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/constants.dart';
import '../helpers/make_trip.dart';
import '../widgets/sliding_heading.dart';

class Home extends StatefulWidget {
  var info;
  Home(this.info, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List list = [{

    'name':'name',
     'namee':'namee',
      'dis_ar':'name',
       'dis_en':'name',
        'kilo_price':'10.0',
         'sec_price':'20.0',
  }];
  getvehicle() {
    checkInternetConnection().then((value) => value == 1
        ? http.get(Uri.parse('${url}api/car'), headers: {
            "Accept": "application/json",
          }).then((value) {
            if (value.statusCode == 200 || value.statusCode == 201) {
            List l =jsonDecode(value.body);
            if(l.isNotEmpty){
                 setState(() {
                list = jsonDecode(value.body);
              });
            }
              // print( jsonDecode(value.body));
             
            } else {
              errono("خطأ من مشغلاتنا، نعتذر", "Server error", context);
            }
          })
        : errono("تعذر الإتصال بالإنترنت", "Unable to connect to the Internet",
            context));
  }

  bool wait = false;
  var choosenType;
  @override
  void initState() {
    getMyOreders(widget.info, context);
    getvehicle();
   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (list.isNotEmpty) {
        choosenType = list[
            Provider.of<VehicleTypeController>(context, listen: false).index !=
                    0
                ? Provider.of<VehicleTypeController>(context, listen: false)
                        .index -
                    1
                : 0];
      }

      if (Provider.of<VehicleTypeController>(context, listen: false).index !=
              0 &&
          Provider.of<VehicleTypeController>(context, listen: false)
              .dropPoint
              .isNotEmpty &&
          Provider.of<VehicleTypeController>(context, listen: false)
              .firstPoint
              .isNotEmpty &&
          Provider.of<VehicleTypeController>(context, listen: false).finalFee !=
              null) {
        var distance = calculateDistance(
            LatLng(
                double.parse(
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .firstPoint[1]),
                double.parse(
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .firstPoint[2])),
            LatLng(
                double.parse(
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .dropPoint[1]),
                double.parse(
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .dropPoint[2])));

        Provider.of<VehicleTypeController>(context, listen: false)
            .setDestance(distance.toStringAsFixed(2));

        Provider.of<VehicleTypeController>(context, listen: false).setfinalFee(
            colculatingFedd(
                choosenType['kilo_price'], choosenType['sec_price'], distance));
      }
    });

    return Scaffold(
      key: _key,
      drawer: drawer(context, widget.info),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
              color: Theme.of(context).colorScheme.primary,
      
          ),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('lib/assets/colored.png'),
            ),
            GradientText(
              context.watch<VehicleTypeController>().la ? "سعاة" : "Souat",
              gradient: LinearGradient(colors: [
                Colors.pink.shade700,
                Colors.purple.shade900,
              ]),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: (() =>
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .setLa(!Provider.of<VehicleTypeController>(context,
                                listen: false)
                            .la)),
                child: Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
               
                )),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
  
          Visibility(
            visible: widget.info['account']=='0'&& Provider.of<VehicleTypeController>(context, listen: false).finalFee=='0.00',
            child: const SlidingHeadings()),




          PointsCard(widget.info),
          Visibility(
            visible: list.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: context.watch<VehicleTypeController>().la
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    context.watch<VehicleTypeController>().la
                        ? 'المركبات المتوفرة'
                        : "Available vehicles",
                  ),
                ],
              ),
            ),
          ),
          for (int i = 1; i <= list.length; i++) VehicleType(list[i - 1], i)
        ],
      ),
      floatingActionButton: Visibility(
        visible: context.watch<VehicleTypeController>().index != 0 &&
            context.watch<VehicleTypeController>().dropPoint.isNotEmpty &&
            context.watch<VehicleTypeController>().firstPoint.isNotEmpty &&
            double.parse(
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .finalFee) >
                1.00,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              wait = !wait;
            });

            checkInternetConnection().then((value) => value == 1
                ? makeTrip(context, widget.info, choosenType).then((isItDone) =>
                    Future.delayed(const Duration(microseconds: 1))
                        .then((kjfsaghiJK) => mounted && !isItDone
                            ? {
                                setState(() => wait = false),
                                errono(
                                    "تعذر الإتصال بمشغلاتنا، رجاء حاول مرة أخرى",
                                    "Unable to contact our operators, please try again",
                                    context)
                              }
                            : null))
                : errono("تعذر الإتصال بالإنترنت",
                    "Unable to connect to the Internet", context));
          },
          label: Text(context.watch<VehicleTypeController>().la
              ? 'الى الرحلة'
              : 'To the trip!',style: const TextStyle( color: Colors.white,),),
          icon: const Icon(
            MdiIcons.tankerTruck,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
