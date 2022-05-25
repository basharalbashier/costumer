import 'dart:async';
import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/pages/models/get_polyline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'models/retun_icon.dart';

class OrderScreen extends StatefulWidget {
  Map orderInfo;
  OrderScreen(this.orderInfo, {Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  check() {
    http
        .get(Uri.parse('${url}api/orders/${widget.orderInfo['id']}'),
            headers: header)
        .then((value) {
      // setState(() {
      //   list = jsonDecode(value.body);
      // });
      if (kDebugMode) {
        // print(jsonDecode(value.body));
      }
      // for (var i in list) {
      //   if (kDebugMode) {
      //     print(i);
      //   }
      // }
    });
  }
  
    Completer<GoogleMapController> _controller = Completer();
   GoogleMapController? mapController;
  Set<Polyline> polylines = {};

  setpolylines() {
    getPolyLine(
        LatLng(
          double.parse(widget.orderInfo['start_late']),
          double.parse(widget.orderInfo['start_longe']),
        ),
        LatLng(
          double.parse(widget.orderInfo['end_late']),
          double.parse(widget.orderInfo['end_longe']),
        )).then((value) {
      setState(() {
        polylines = value;
        updateCameraLocation( LatLng(
          double.parse(widget.orderInfo['start_late']),
          double.parse(widget.orderInfo['start_longe']),
        ),  LatLng(
          double.parse(widget.orderInfo['end_late']),
          double.parse(widget.orderInfo['end_longe']),
        ),  mapController!);
      });
    });
  }

  @override
  void initState() {
    check();
      setpolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              polylines: polylines,
              myLocationEnabled: true,
              // onTap: (o) {
              //   print(o);
              // },
              // markers: Set<Marker>.of(_markers.values),
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.orderInfo['start_late']),
                    double.parse(widget.orderInfo['start_longe'])),
                zoom: 10.0,
              ),
              onMapCreated: _onMapCreated,
              onCameraMove: (CameraPosition position) {}),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(widget.orderInfo.toString()),
          // ),
    
             Positioned(
              top: 50,
              left: 10,
              child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.white.withOpacity(.5),
                 // boxShadow: [
                 //   BoxShadow(color: Colors.white, spreadRadius: 1),
                 // ],
               ),
               width: MediaQuery.of(context).size.width - 20,
               // height: 50,

               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                    GestureDetector(
                      onTap:() => Get.back(),
                      child: Icon(CupertinoIcons.back)),
                
                   Expanded(
                         // flex: 5,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0),
                         child: Container(
                           child: FittedBox(
                             fit: BoxFit.scaleDown,
                             child: Text(widget.orderInfo['distance']
                               
                                       ,
                               // style: Theme.of(context).textTheme.headline6,
                             ),
                           ),
                         ),
                       ),
                      
                     ),
                  
                    GestureDetector(
                      onTap:() => Get.back(),
                      child: Icon(Icons.cancel_rounded,color: Colors.pink.shade200,)),
                
                   ],
                 ),
               ),
                ))
       
       ,
             Positioned(
            bottom: 0,
            left: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(.9),
                // boxShadow: [
                //   BoxShadow(color: Colors.white, spreadRadius: 1),
                // ],
              ),
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 3,

              // height: 50,

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    child: ListView(
                       padding: EdgeInsets.only(top:5),
                  children: [
                    Row(
                      children: [
                         Icon(
                          Icons.trip_origin,color: Colors.pink.shade200,
                          size: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              'Pick-up address: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        )
                      ],
                    ),
                    FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          widget.orderInfo['start_address'],
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CommunityMaterialIcons.map_marker,color: Colors.pink.shade200,
                          size: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Drop-off address: ',
                              style: Theme.of(context).textTheme.headline6,
                            ),

                            // FittedBox(
                            //         fit: BoxFit.contain,child: Text(widget.orderInfo['end_address'],overflow: TextOverflow.ellipsis,)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      widget.orderInfo['end_address'],
                      textAlign: TextAlign.start,
                      // style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                   SizedBox(
                      height: 20,
                    ),
                    Divider(),
                   SizedBox(
                      height: 20,
                    ),
                    
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     statusIcon('0'),
                      Text(
                      widget.orderInfo['fee']+' SAR',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],),
                  ],
                )),
              ),
            ),
          ),
         
           
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.location_north_line),
        onPressed: () {
        

            setState(() {
                  updateCameraLocation( LatLng(
          double.parse(widget.orderInfo['start_late']),
          double.parse(widget.orderInfo['start_longe']),
        ),  LatLng(
          double.parse(widget.orderInfo['end_late']),
          double.parse(widget.orderInfo['end_longe']),
        ),  mapController!);
            });
      },),
    );
  }













  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);
    final c = await _controller.future;

  }
  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {

    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}
