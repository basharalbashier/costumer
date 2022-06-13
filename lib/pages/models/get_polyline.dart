import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;




class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});
  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf624845d06d7f9a984170b1640d082f1bfa3a';
  final String journeyMode = 'driving-car';
// Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;
  Future getData() async {
    // http.Response response = await http.get(Uri.parse(
    //     '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));

    // // print(
    // //     "$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");
    // if (response.statusCode == 200) {
    //   String data = response.body;
    //   print(data);
    //   // print(jsonDecode(data)['features'][0]['properties']['summary']);

    //   return jsonDecode(data);
    // } else {
    //   // print(response.statusCode);
    // }
  }
}


class Linestring {
  Linestring(this.linestring);
  List<dynamic> linestring;
}


  Future<Set<Polyline>>  getPolyLine(LatLng a, LatLng b,context) async {
    NetworkHelper network = NetworkHelper(
      startLat: a.latitude,
      startLng: a.longitude,
      endLat: b.latitude,
      endLng: b.longitude,
    );

      final List<LatLng> polypoints = [];
       final Set<Polyline> polylines = {};
   
    try {
      // getdata() returns a json decoded data
      var data = await network.getData();
      // we can reach to our desired json data manually as following
      Linestring ls =
          Linestring(data['features'][0]['geometry']['coordinates']);
      for (int i = 0; i < ls.linestring.length; i++) {
        polypoints.add(LatLng(ls.linestring[i][1], ls.linestring[i][0]));
      }
      if (polypoints.length == ls.linestring.length) {
        // setState(() {
        //   d = '${((double.parse('${data['features'][0]['properties']['summary']['distance']}') / 1000).toStringAsFixed(1))}/Km';
        // });
     
      }

          Polyline polyline = Polyline(
      width: 3,
      polylineId: const PolylineId("polyline"),
      color: Theme.of(context).colorScheme.secondary,
      points: polypoints,
    );
        polylines.add(polyline);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return polylines;
  }
