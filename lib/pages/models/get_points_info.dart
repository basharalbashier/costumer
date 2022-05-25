import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

Future<List> getCordinateInfo(double latitude, double longtude) async {
  List<String?> list = [];
try{
    await placemarkFromCoordinates(latitude, longtude).then((value) {
  
    list.add(value[0].isoCountryCode);
    list.add(value[0].locality);
    list.add(value[0].subLocality);
    list.add(value[0].thoroughfare);
    list.add(value[0].name);

    // print(value);
  });
}catch(e){
if (kDebugMode) {
  print(e);
}
}
  return list;
}
