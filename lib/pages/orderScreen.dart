import 'dart:async';
import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/helpers/show_cancel_buttomsheet.dart';
import 'package:costumer/pages/models/get_polyline.dart';
import 'package:costumer/pages/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'check_page.dart';
import 'models/retun_icon.dart';

class OrderScreen extends StatefulWidget {
  Map orderInfo;
  OrderScreen(this.orderInfo, {Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Map? orderInfo;
  check() {
    http
        .get(Uri.parse('${url}api/orders/${widget.orderInfo['id']}'),
            headers: header)
        .then((value) {
      setState(() {
        orderInfo = jsonDecode(value.body);
      });
      Provider.of<VehicleTypeController>(context, listen: false)
          .statusUpdate(orderInfo!['status']);

if(orderInfo!['status']=='11'){
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RateProvider(orderInfo!['id'])),
      (Route<dynamic> route) => false,
    );
}
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
          double.parse(orderInfo!['start_late']),
          double.parse(orderInfo!['start_longe']),
        ),
        LatLng(
          double.parse(orderInfo!['end_late']),
          double.parse(orderInfo!['end_longe']),
        )).then((value) {
      if (mounted) {
        setState(() {
          polylines = value;
          updateCameraLocation(
              LatLng(
                double.parse(orderInfo!['start_late']),
                double.parse(orderInfo!['start_longe']),
              ),
              LatLng(
                double.parse(orderInfo!['end_late']),
                double.parse(orderInfo!['end_longe']),
              ),
              mapController!);
        });
      }
    });
  }

  Timer? _checkingTimer;
  @override
  void initState() {
    orderInfo = widget.orderInfo;
    _checkingTimer = Timer.periodic(Duration(seconds:orderInfo!['status']=='0'? 20:360), (Timer t) {
      check();
    });
    super.initState();
  }

  @override
  void dispose() {
    _checkingTimer!.cancel();

    super.dispose();
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
                target: LatLng(double.parse(orderInfo!['start_late']),
                    double.parse(orderInfo!['start_longe'])),
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
                      statusIcon(context.watch<VehicleTypeController>().status,context.watch<VehicleTypeController>().la
              ),
                      Expanded(
                        // flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(),
                        ),
                      ),
                      Visibility(visible:   orderInfo!['status'] !='11',
                        child: GestureDetector(
                            onTap: () {
                              showCancelBottomSheet(context, orderInfo!['id'],Provider.of<VehicleTypeController>(context, listen: false).la);
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              color: Colors.pink.shade200,
                            )),
                      ),
                    ],
                  ),
                ),
              )),

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
                  padding: EdgeInsets.only(top: 5),
                  children: [
                    Visibility(
                      visible: orderInfo!['provider_name'] != null,
                      child:  GestureDetector(
                          onTap:(){
                                launch("tel://+966${orderInfo!['provider_phone']}");
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              orderInfo!['provider_name'] ?? '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              orderInfo!['provider_phone'] ?? '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.trip_origin,
                          color: Colors.pink.shade200,
                          size: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(context.watch<VehicleTypeController>().la?'نقطة البداية':
                              'Pick-up address: ',
                              style: Theme.of(context).textTheme.headline6,
                              // textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                    FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          orderInfo!['start_address'],
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CommunityMaterialIcons.map_marker,
                          color: Colors.pink.shade200,
                          size: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.watch<VehicleTypeController>().la?"عنوان التسليم":
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
                      orderInfo!['end_address'],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          orderInfo!['fee'] + ' ${context.watch<VehicleTypeController>().la?"ر.س":"SAR"} ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          orderInfo!['distance'] + ' ${context.watch<VehicleTypeController>().la?"ك.م":"KM"} ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
            updateCameraLocation(
                LatLng(
                  double.parse(orderInfo!['start_late']),
                  double.parse(orderInfo!['start_longe']),
                ),
                LatLng(
                  double.parse(orderInfo!['end_late']),
                  double.parse(orderInfo!['end_longe']),
                ),
                mapController!);
          });
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);
    final c = await _controller.future;
    setpolylines();
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
