import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

Future<List> getCordinateInfo(double latitude, double longtude) async {
  List<String?> list = [];
try{
  var value=  await placemarkFromCoordinates(latitude, longtude);
  
    list.add(value[0].isoCountryCode);
    list.add(value[0].locality);
    list.add(value[0].subLocality);
    list.add(value[0].thoroughfare);
    list.add(value[0].name);

    return list;
  
}catch(e){
 return [];
}
 
}
