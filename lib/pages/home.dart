import 'dart:convert';

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
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
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

  makeTrip() {
    try {
      http.post(Uri.parse('${url}api/orders'), headers: header, body: {
        'user_name': widget.info['name'],
        'user_phone': widget.info['phone'],
        'start_address':
            Provider.of<VehicleTypeController>(context, listen: false)
                .firstPoint[0],
        'start_late': Provider.of<VehicleTypeController>(context, listen: false)
            .firstPoint[1],
        'start_longe':
            Provider.of<VehicleTypeController>(context, listen: false)
                .firstPoint[2],
        'end_address':
            Provider.of<VehicleTypeController>(context, listen: false)
                .dropPoint[0],
        'end_late': Provider.of<VehicleTypeController>(context, listen: false)
            .dropPoint[1],
        'end_longe': Provider.of<VehicleTypeController>(context, listen: false)
            .dropPoint[2],
        'fee':
            Provider.of<VehicleTypeController>(context, listen: false).finalFee,
        'car_type': choosenType['id'].toString(),
        'distance': Provider.of<VehicleTypeController>(context, listen: false)
            .distanceData,
        'status': '0',
      }).then((value) {
        if ((value.statusCode == 200 || value.statusCode == 201) &&
            Provider.of<VehicleTypeController>(context, listen: false)
                    .firstPoint[1] ==
                jsonDecode(value.body)['start_late']) {
          if (kDebugMode) {
            print(jsonDecode(value.body)['start_late']);
          }
          Map i = jsonDecode(value.body);
          Get.to(OrderScreen(i));
        } else {
          if (kDebugMode) {
            print('noooooo');
          }
        }
        // for (var i in list) {
        //   if (kDebugMode) {
        //
        //   }
        // }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  var choosenType;
  @override
  void initState() {
    getvehicle();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(list.isEmpty)
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

          const PointsCard(),

          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Available vehicles",
              // style: Theme.of(context).textTheme.bodySmall,
            ),
          ),

          //vehicle type
          for (int i = 1; i <= list.length; i++) VehicleType(list[i - 1], i)
        ],
      ),
      floatingActionButton: Visibility(
        visible: context.watch<VehicleTypeController>().index != 0 &&
            context.watch<VehicleTypeController>().dropPoint.isNotEmpty &&
            context.watch<VehicleTypeController>().firstPoint.isNotEmpty,
        child: FloatingActionButton.extended(
          onPressed: () {
            makeTrip();
          },
          label: const Text('To the trip!'),
          icon: const Icon(Icons.delivery_dining),
        ),
      ),
    );
  }











}
