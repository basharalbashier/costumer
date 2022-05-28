import 'dart:convert';

import 'package:costumer/helpers/get_my_orders.dart';
import 'package:costumer/pages/models/colculating_distans.dart';
import 'package:costumer/pages/models/colculating_fee.dart';
import 'package:costumer/pages/orderScreen.dart';
import 'package:costumer/widgets/poins_cards.dart';
import 'package:costumer/widgets/sliding_heading.dart';
import 'package:costumer/widgets/vehicle_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/make_trip.dart';
import '../main.dart';

class Home extends StatefulWidget {
  var info;
   Home(this.info,{Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List list = [
    // {
    //   'id': '1',
    //   'name': 'orfoj',
    //   'namee': 'iqhgqih',
    //   'cap_en': 'cap_en',
    //   'dis_en': 'dis_en',
    //   'kilo_price': '10.00',
    //   'sec_price': '20.00'
    // },
    // {
    //   'id': '2',
    //   'name': 'bkjb,bbb',
    //   'namee': 'nmnvmnbhgdfgd',
    //   'cap_en': 'jhkfkhgfhgkfghk',
    //   'dis_en': 'jhfkkfuy',
    //   'kilo_price': '50.00',
    //   'sec_price': '80.00'
    // },
  ];
  getvehicle() {
    http.get(Uri.parse(url + 'api/car'), headers: header).then((value) {
      setState(() {
        list = jsonDecode(value.body);
      });
      // if (kDebugMode) {
      //   print(list);
      // }
      // for (var i in list) {
      //   if (kDebugMode) {
      //     print(i);
      //   }
      // }
    });
  }

 bool wait=false;
  var choosenType;
  @override
  void initState() {

    getMyOreders(widget.info['phone'], context);
    getvehicle();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(list.isEmpty || wait)
   {
  
      return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()),);
       
   }
       
        FlutterNativeSplash.remove();
      WidgetsBinding.instance.addPostFrameCallback((_) {
    choosenType = list[ Provider.of<VehicleTypeController>(context, listen: false).index != 0
        ?  Provider.of<VehicleTypeController>(context, listen: false).index - 1
        : 0];

    if ( Provider.of<VehicleTypeController>(context, listen: false).index != 0 &&
        Provider.of<VehicleTypeController>(context, listen: false).dropPoint.isNotEmpty &&
       Provider.of<VehicleTypeController>(context, listen: false).firstPoint.isNotEmpty &&
         Provider.of<VehicleTypeController>(context, listen: false).finalFee != null) {
      var distance = calculateDistance(
          LatLng(
              double.parse( Provider.of<VehicleTypeController>(context, listen: false).firstPoint[1]),
              double.parse(
                   Provider.of<VehicleTypeController>(context, listen: false).firstPoint[2])),
          LatLng(
              double.parse( Provider.of<VehicleTypeController>(context, listen: false).dropPoint[1]),
              double.parse(
                   Provider.of<VehicleTypeController>(context, listen: false).dropPoint[2])));

       Provider.of<VehicleTypeController>(context, listen: false)
          .setDestance(distance.toStringAsFixed(2));

      Provider.of<VehicleTypeController>(context, listen: false).setfinalFee(colculatingFedd(
          choosenType['kilo_price'], choosenType['sec_price'], distance));
   
    }
    });

    return Scaffold(
      // drawer: Drawer(),
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //   icon: const Icon(Icons.menu_open_sharp),
      //   //   onPressed: () => Scaffold.of(context).openDrawer(),
      //   // ),
      //   // backgroundColor: Colors.white,
      //   title: Center(child: const Text('Delivery')),
      //   actions: [const Icon(Icons.notifications_active_rounded)],
      // ),
    
      body: ListView(
        children: <Widget>[
          // const SlidingHeadings(),
          //pick location

           PointsCard(widget.info),

           Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              mainAxisAlignment:context.watch<VehicleTypeController>().la?MainAxisAlignment.end:MainAxisAlignment.start ,
              children: [
                Text(
           context.watch<VehicleTypeController>().la?'المركبات المتوفرة':     "Available vehicles",
                  // style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          //vehicle type
          for (int i = 1; i <= list.length; i++) VehicleType(list[i - 1], i)
        ],
      ),
      floatingActionButton: Visibility(
        visible: context.watch<VehicleTypeController>().index != 0 &&
            context.watch<VehicleTypeController>().dropPoint.isNotEmpty &&
            context.watch<VehicleTypeController>().firstPoint.isNotEmpty && double.parse(Provider.of<VehicleTypeController>(context, listen: false).finalFee)>1.00,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              wait=!wait;
            });
            makeTrip(context,widget.info,choosenType).then((value) => Future.delayed(Duration(seconds: 30)).then((value) =>mounted?setState(()=>wait=false):null));
          },
          label:  Text(context.watch<VehicleTypeController>().la?'الى الرحلة':'To the trip!'),
          icon: const Icon(  MdiIcons.tankerTruck,),
        ),
      ),
    );
  }











}
