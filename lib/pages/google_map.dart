import 'dart:async';

import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/pages/models/db.dart';
import 'package:costumer/pages/models/get_location.dart';
import 'package:costumer/pages/models/get_points_info.dart';
import 'package:costumer/pages/what_can_we_move.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/poins_cards.dart';
import 'home.dart';

class Mapi extends StatefulWidget {
  final int whichOne;
  var info;
  Mapi(this.whichOne, this.info, {Key? key}) : super(key: key);

  @override
  State<Mapi> createState() => _MapiState();
}

class _MapiState extends State<Mapi> {
  final Completer<GoogleMapController> _controller = Completer();
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  LatLng? currentCoordinat;
  LatLng? initialPosition;
  List<dynamic> fullAdress = [];
  @override
  void initState() {
    getlocation(context).then((value) {
      if (value.latitude != null) {
        setState(() {
          initialPosition = LatLng(value.latitude, value.longitude);
        });
        moveCameraTocurrent(value.latitude, value.longitude);
      }
    });
    super.initState();
  }
//toty LatLng(15.618656147776102, 32.502314485609524)
//bahri LatLng(15.649954975330912, 32.553354911506176)
// omdorman LatLng(15.644554970456632, 32.4723307415843)
// riyad LatLng(24.66164641810484, 46.65585301816464)

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(right: screenWidth / 6),
      //   child: FloatingActionButton.extended(
      //     // extendedIconLabelSpacing:100.0,
      //     onPressed: () {
      //       if (Provider.of<VehicleTypeController>(context, listen: false)
      //           .dropPoint
      //           .isNotEmpty) {
      //         DBProvider.db.addPoint(
      //             Provider.of<VehicleTypeController>(context, listen: false)
      //                 .dropPoint);
      //       } else {
      //         DBProvider.db.addPoint(
      //             Provider.of<VehicleTypeController>(context, listen: false)
      //                 .firstPoint);
      //       }
      //       if (Provider.of<VehicleTypeController>(context, listen: false)
      //           .dropPoint
      //           .isEmpty) {
      //         Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (context) => Mapi(1, widget.info)),
      //           (Route<dynamic> route) => false,
      //         );
      //       } else {
      //         Get.to(() => Home(widget.info));
      //       }
      //     },
      //     label: SizedBox(
      //         width: screenWidth / 2,
      //         child: Center(
      //             child: Text(
      //           context.watch<VehicleTypeController>().dropPoint.isEmpty
      //               ? context.watch<VehicleTypeController>().la
      //                   ? 'الى نقطة النهاية'
      //                   : 'End Point'
      //               : context.watch<VehicleTypeController>().la
      //                   ? 'الى النقل'
      //                   : 'To the trip!',
      //           style: const TextStyle(
      //               color: Colors.white, fontWeight: FontWeight.w900),
      //         ))),
      //     // icon: const Icon(Icons.delivery_dining),
      //   ),
      // ),

      body: Stack(
        children: [
          ///map
          initialPosition == null
              ? const Center()
              : SizedBox(
                  width: screenWidth,
                  child: GoogleMap(
                      myLocationEnabled: true,
                      onTap: (o) {
                        if (kDebugMode) {
                          print(o);
                        }
                      },
                      markers: Set<Marker>.of(_markers.values),
                      initialCameraPosition: CameraPosition(
                        target: initialPosition!,
                        zoom: 18.0,
                      ),
                      onMapCreated: _onMapCreated,
                      onCameraMove: (CameraPosition position) {
                        if (_markers.length > 0) {
                          MarkerId markerId = MarkerId(_markerIdVal());
                          Marker marker = _markers[markerId]!;
                          Marker updatedMarker = marker.copyWith(
                            positionParam: position.target,
                          );

                          setState(() {
                            getCordinateInfo(position.target.latitude,
                                    position.target.longitude)
                                .then((n) {
                              fullAdress = n;
                              widget.whichOne == 0
                                  ? context
                                      .read<VehicleTypeController>()
                                      .setFirstPoint([
                                      fullAdress.isNotEmpty
                                          ? '${fullAdress[0]}, ${fullAdress[1]}, ${fullAdress[2]}, ${fullAdress[3]}'
                                          : '',
                                      position.target.latitude.toString(),
                                      position.target.longitude.toString()
                                    ])
                                  : context
                                      .read<VehicleTypeController>()
                                      .setDropPoint([
                                      fullAdress.isNotEmpty
                                          ? '${fullAdress[0]}, ${fullAdress[1]}, ${fullAdress[2]}, ${fullAdress[3]}'
                                          : '',
                                      position.target.latitude.toString(),
                                      position.target.longitude.toString()
                                    ]);
                            });
                            _markers[markerId] = updatedMarker;
                          });
                        }
                      }),
                ),

          //app widget

          SizedBox(width: screenWidth, child: PointsCard(widget.info)),

          Positioned(
            bottom: 0,
            child:
             Container(
                width: screenWidth,
                height: screenHight / 8,
                color: Colors.white.withOpacity(0.7),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed:()=>Get.to(()=>Home(Provider.of<VehicleTypeController>(context, listen: false).info)),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(CupertinoIcons.back),
                                          Text(
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                            context
                                                    .watch<
                                                        VehicleTypeController>()
                                                    .la
                                                ? "رجوع"
                                                : "Back",
                                          ),
                                          Container()
                                        ],
                                      ),
                                    ),
                                  )))),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  textColor: Colors.white,
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    if (Provider.of<VehicleTypeController>(
                                            context,
                                            listen: false)
                                        .dropPoint
                                        .isNotEmpty) {
                                      DBProvider.db.addPoint(
                                          Provider.of<VehicleTypeController>(
                                                  context,
                                                  listen: false)
                                              .dropPoint);
                                    } else {
                                      DBProvider.db.addPoint(
                                          Provider.of<VehicleTypeController>(
                                                  context,
                                                  listen: false)
                                              .firstPoint);
                                    }
                                    if (Provider.of<VehicleTypeController>(
                                            context,
                                            listen: false)
                                        .dropPoint
                                        .isEmpty) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Mapi(1, widget.info)),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      Get.to(() => const ApplyOrder());
                                    }
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text(
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                          context
                                                  .watch<
                                                      VehicleTypeController>()
                                                  .la
                                              ? "التالي"
                                              : "Next",
                                        ),
                                        const Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )))),
                    ])),
          
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    if (initialPosition != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = initialPosition!;
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
      );
      setState(() {
        getCordinateInfo(position.latitude, position.longitude)
            .then((value) => fullAdress = value);
        _markers[markerId] = marker;
      });

      Future.delayed(const Duration(seconds: 2), () async {
        GoogleMapController controller = await _controller.future;
        if (mounted) {
          setState(() {
            getCordinateInfo(position.latitude, position.longitude)
                .then((value) => fullAdress = value);
            // _markers[markerId] = marker;
          });
        }
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              tilt: 59.440717697143555,
              zoom: 13.151926040649414,
              target: position,
              // zoom: 8.0,
            ),
          ),
        );
      });
    }
  }

  Future<void> moveCameraTocurrent(lt, lg) async {
    //how to change camera posision
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(lt, lg),
        tilt: 59.440717697143555,
        zoom: 13.151926040649414)));
  }

  String _markerIdVal({bool increment = false}) {
    // print('object');
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }
}
