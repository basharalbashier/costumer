

import 'package:flutter/material.dart';

Widget statusIcon(String statuse){


  if(1==1){

  }else if(1==1){

  }

return Row(children: [
  Text('Status : Searching for a vehicle'),
  Padding(
    padding: const EdgeInsets.only(left:15.0),
    child:  CircularProgressIndicator(backgroundColor:  Colors.pink.shade200,strokeWidth: .5,),
  ),
],);

}