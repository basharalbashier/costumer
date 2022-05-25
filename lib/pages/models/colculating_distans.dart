import 'dart:math' show cos, sqrt, asin;

double calculateDistance(p1, p2) {
  double lat1 = p1.latitude;
  double lon1 = p1.longitude;
  double lat2 = p2.latitude;
  double lon2 = p2.longitude;

  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      (c((lat2 - lat1) * p) / 2) +
      c(lat1 * p) * c(lat2 * p) * ((1 - c((lon2 - (lon1)) * p)) / 2);
  var distance = 12742 * asin(sqrt(a));
  // 
  // print(distance *1000);

  return distance;
}
