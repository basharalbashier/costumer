import 'dart:async';
import 'dart:collection';

import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:costumer/helpers/make_trip.dart';
import 'package:costumer/pages/models/get_location.dart';
import 'package:costumer/pages/models/get_points_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class Mapi extends StatefulWidget {
  int whichOne;
  var info;
   Mapi(this.whichOne,this.info,{Key? key}) : super(key: key);

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
    getlocation().then((value) {
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
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(




      floatingActionButton: Padding(
        padding:EdgeInsets.only(right: screenWidth/6),
        child: FloatingActionButton.extended(
          
          // extendedIconLabelSpacing:100.0,
          onPressed: () {
            if(Provider.of<VehicleTypeController>(context, listen: false).dropPoint.isEmpty){
       
                    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Mapi(1,widget.info)),
      (Route<dynamic> route) => false,
    );
            
            }else{
      Get.to(() =>Home(widget.info));
            }
           
          },
          label: SizedBox( width:screenWidth/2 ,
            child: Center(child:  Text(context.watch<VehicleTypeController>().dropPoint.isEmpty?context.watch<VehicleTypeController>().la?'الى نقطة النهاية':'End Point':  context.watch<VehicleTypeController>().la?'الى النقل':'To the trip!'))),
          // icon: const Icon(Icons.delivery_dining),
        ),
      ),





      body: Stack(
        children: [
          ///map
          initialPosition == null
              ? Center()
              : 
              SizedBox(width: screenWidth,
                child: GoogleMap(
                    myLocationEnabled: true,
                    onTap: (o) {
                      print(o);
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
                            widget.whichOne==0?
                            context.read<VehicleTypeController>().setFirstPoint([fullAdress[0] +
                                            ', ' +
                                            fullAdress[1] +
                                            ', ' +
                                            fullAdress[2] +
                                            ',' +
                                            fullAdress[3]+
                                           
                                            ',' +
                                            fullAdress[4],position.target.latitude.toString(), position.target.longitude.toString()]):context.read<VehicleTypeController>().setDropPoint([fullAdress[0] +
                                            ', ' +
                                            fullAdress[1] +
                                            ', ' +
                                            fullAdress[2] +
                                            ',' +
                                            fullAdress[3]+
                                           
                                            ',' +
                                            fullAdress[4],position.target.latitude.toString(), position.target.longitude.toString()]);
                          });
                          _markers[markerId] = updatedMarker;
                        });
                      }
                    }),
              ),

          //app widget

          Positioned(
              top: 50,
              left: 10,
              child: Visibility(
                visible: fullAdress.isNotEmpty,
                child:
                 Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.5),
                    // boxShadow: [
                    //   BoxShadow(color: Colors.white, spreadRadius: 1),
                    // ],
                  ),
                  width: screenWidth - 20,
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
                                fit: BoxFit.contain,
                                child: Text(
                                  fullAdress.isEmpty
                                      ? ''
                                      : fullAdress[0] +
                                          ', ' +
                                          fullAdress[1] +
                                          ', ' +
                                          fullAdress[2] +
                                          ' \n' +
                                          fullAdress[3]+
                                         
                                          ' \n' +
                                          fullAdress[4]
                                          ,
                                  // style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
             
              ))
       
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

      Future.delayed(Duration(seconds: 2), () async {
        GoogleMapController controller = await _controller.future;
        setState(() {
          getCordinateInfo(position.latitude, position.longitude)
              .then((value) => fullAdress = value);
          // _markers[markerId] = marker;
        });
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
