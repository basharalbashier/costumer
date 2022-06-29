import 'package:flutter/material.dart';

class VehicleTypeController extends ChangeNotifier {
Map info={};
int index =0;
List<String> firstPoint=[];
List<String> dropPoint=[];
String finalFee='0.00';
String distance='';
bool la=true;
Map chosen={};
String byer='';
String byerPhone='';


int get count => index;
List<String>  get firstPointData => firstPoint;

List<String>  get dropPointData => dropPoint;
String  get finalFeeData => finalFee;
String  get distanceData => distance;
bool  get laData => la;
Map  get infoDate => info;
Map  get chosenData => chosen;
String  get byerdate => byer;
String  get byerPhonedate => byerPhone;

String status ='0';



String  get statusDate => status;

byerUpdate(String mp){
  byer=mp;
  notifyListeners();

}
byerPhoneUpdate(String mp){
  byerPhone=mp;
  notifyListeners();

}
infoUpdate(Map mp){
  info=mp;
  notifyListeners();

}
chosenUpdate(Map mp){
  chosen=mp;
  notifyListeners();

}


updateDrop(String v){
  dropPoint[0]="${dropPoint[0]}, $v";
  notifyListeners();
}

statusUpdate(String st){
  status=st;
  notifyListeners();

}

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
