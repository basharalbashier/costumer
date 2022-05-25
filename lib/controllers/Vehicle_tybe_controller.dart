import 'package:flutter/material.dart';

class VehicleTypeController extends ChangeNotifier {
int index =0;
List<String> firstPoint=[];
List<String> dropPoint=[];
String finalFee='';
String distance='';
bool la=true;

int get count => index;
List<String>  get firstPointData => firstPoint;

List<String>  get dropPointData => dropPoint;
String  get finalFeeData => finalFee;
String  get distanceData => distance;
bool  get laData => la;


void setIndex(int i){
  index=i;
  notifyListeners();
}

void setFirstPoint(List<String> fP){
  firstPoint=fP;
  notifyListeners();
}

void setDropPoint(List<String> dP){
  dropPoint=dP;
  notifyListeners();
}

void setfinalFee(String finalFe){
  finalFee=finalFe;
  notifyListeners();
}

void setDestance(String dist){
  distance=dist;
  notifyListeners();
}

setLa(bool language){
  la=language;
  notifyListeners();

}

}
