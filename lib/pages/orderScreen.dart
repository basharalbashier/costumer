import 'dart:async';
import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/helpers/gradiant_icon.dart';
import 'package:costumer/helpers/gradiant_text.dart';
import 'package:costumer/helpers/show_cancel_buttomsheet.dart';
import 'package:costumer/pages/models/get_polyline.dart';
import 'package:costumer/pages/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/check_internet.dart';
import '../helpers/constants.dart';
import '../helpers/error_snack.dart';
import 'check_page.dart';
import 'models/db.dart';
import 'models/retun_icon.dart';

class OrderScreen extends StatefulWidget {
  final Map orderInfo;
  const OrderScreen(this.orderInfo, {Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Map orderInfo = {};
  check() async {
    var info = await DBProvider.db.getMe();
    try {
      await http.get(Uri.parse('${url}api/orders/${widget.orderInfo['id']}'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${info[0]['token']}'
          }).then((value) {
        if (jsonDecode(value.body)['status'] == '4') {
          errono("تم إلغاء الشحن من قبل الإدارة",
              "Shipping has been canceled by management", context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CheckPoint()),
            (Route<dynamic> route) => false,
          );
        }
        if (jsonDecode(value.body)['status'] == '5') {
          errono("قام السائق بإلغاء الشحن", "The driver canceled the shipping",
              context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CheckPoint()),
            (Route<dynamic> route) => false,
          );
        }
        if (mounted) {
          setState(() {
            orderInfo = jsonDecode(value.body);
            Provider.of<VehicleTypeController>(context, listen: false)
                .statusUpdate(orderInfo['status']);
          });
        }

        if (orderInfo['status'] == '11') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => RateProvider(orderInfo['id'])),
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
    } catch (error) {
      // ignore: use_build_context_synchronously
      errono("تعذر الإتصال بالإنترنت", "Unable to connect to the Internet",
          context);
    }
  }

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  Set<Polyline> polylines = {};

  setpolylines() {
    getPolyLine(
            LatLng(
              double.parse(orderInfo['start_late']),
              double.parse(orderInfo['start_longe']),
            ),
            LatLng(
              double.parse(orderInfo['end_late']),
              double.parse(orderInfo['end_longe']),
            ),
            context)
        .then((value) {
      if (mounted) {
        setState(() {
          polylines = value;
          updateCameraLocation(
              LatLng(
                double.parse(orderInfo['start_late']),
                double.parse(orderInfo['start_longe']),
              ),
              LatLng(
                double.parse(orderInfo['end_late']),
                double.parse(orderInfo['end_longe']),
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
    _checkingTimer = Timer.periodic(Duration(seconds: checkTime), (Timer t) {
      checkInternetConnection().then((value) => value == 1
          ? check()
          : errono("تعذر الإتصال بالإنترنت",
              "Unable to connect to the Internet", context));
    });
    super.initState();
  }

  int checkTime = 20;
  @override
  void dispose() {
    _checkingTimer!.cancel();

    super.dispose();
  }

  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    checkTime = orderInfo['status'] == '0' ? 20 : 360;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              polylines: polylines,
              myLocationEnabled: true,
              // onTap: (o) {
              //   print(o);
              // },
              markers: Set<Marker>.of(_markers.values),
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(orderInfo['start_late']),
                    double.parse(orderInfo['start_longe'])),
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
                      statusIcon(context.watch<VehicleTypeController>().status,
                          context.watch<VehicleTypeController>().la),
                      Expanded(
                        // flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(),
                        ),
                      ),
                      Visibility(
                        visible: orderInfo['status'] != '11',
                        child: GestureDetector(
                            onTap: () async {
                              var info = await DBProvider.db.getMe();
                              showCancelBottomSheet(
                                  context,
                                  orderInfo['id'],
                                  Provider.of<VehicleTypeController>(context,
                                          listen: false)
                                      .la,
                                  info[0]);
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              // color: Colors.pink.shade200,
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
                child: ListView(
                  padding: const EdgeInsets.only(top: 5),
                  children: [
                    Visibility(
                      visible: orderInfo['provider_name'] != null,
                      child: GestureDetector(
                        onTap: () {
                          launch("tel://+966${orderInfo['provider_phone']}");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              orderInfo['provider_name'] ?? '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              orderInfo['provider_phone'] ?? '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GradientIcon(
                          gradient: LinearGradient(colors: [
                            Colors.pink.shade700,
                            Colors.purple.shade900,
                          ]),
                          Icons.trip_origin,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            GradientText(
                              gradient: LinearGradient(colors: [
                                Colors.pink.shade700,
                                Colors.purple.shade900,
                              ]),
                              context.watch<VehicleTypeController>().la
                                  ? 'نقطة البداية'
                                  : 'Pick-up address: ',
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
                          orderInfo['start_address'],
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientIcon(
                          gradient: LinearGradient(colors: [
                            Colors.pink.shade700,
                            Colors.purple.shade900,
                          ]),
                          CommunityMaterialIcons.map_marker,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              context.watch<VehicleTypeController>().la
                                  ? "عنوان التسليم"
                                  : 'Drop-off address: ',
                              style: Theme.of(context).textTheme.headline6,
                              gradient: LinearGradient(colors: [
                                Colors.pink.shade700,
                                Colors.purple.shade900,
                              ]),
                            ),

                            // FittedBox(
                            //         fit: BoxFit.contain,child: Text(widget.orderInfo['end_address'],overflow: TextOverflow.ellipsis,)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      orderInfo['end_address'],
                      textAlign: TextAlign.start,
                      // style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          orderInfo['fee'] +
                              ' ${context.watch<VehicleTypeController>().la ? "ر.س" : "SAR"} ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          orderInfo['distance'] +
                              ' ${context.watch<VehicleTypeController>().la ? "ك.م" : "KM"} ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          CupertinoIcons.arrow_down,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            updateCameraLocation(
                LatLng(
                  double.parse(orderInfo['start_late']),
                  double.parse(orderInfo['start_longe']),
                ),
                LatLng(
                  double.parse(orderInfo['end_late']),
                  double.parse(orderInfo['end_longe']),
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
    await _controller.future;
    setpolylines();
      final Marker marker = Marker(
           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        markerId: const MarkerId('0'),
        position: LatLng(
          double.parse(orderInfo['start_late']),
          double.parse(orderInfo['start_longe']),
        ),
        infoWindow: InfoWindow(
            title: Provider.of<VehicleTypeController>(context, listen: false).la
                ? "نقطة الشحن"
                : "Shipping location"),
        onTap: () {},
      );
      final Marker markerTwo = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        markerId: const MarkerId('1'),
        position: LatLng(
          double.parse(orderInfo['end_late']),
          double.parse(orderInfo['end_longe']),
        ),
        infoWindow: InfoWindow(
            title: Provider.of<VehicleTypeController>(context, listen: false).la
                ? "نقطة التوصيل"
                : "Drop location"),
        onTap: () {},
      );

      setState(() {
        // adding a new marker to map
        _markers[const MarkerId('0')] = marker;
        _markers[const MarkerId('1')] = markerTwo;
      });
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
